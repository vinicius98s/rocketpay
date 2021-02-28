defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Vinicius",
        password: "vinicius",
        nickname: "vinicius",
        email: "vinicius@sales.com",
        age: 22
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Vinicius", age: 22, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Vinicius",
        password: "vinicius",
        nickname: "vinicius",
        email: "vinicius@sales.com",
        age: 17
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"]
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
