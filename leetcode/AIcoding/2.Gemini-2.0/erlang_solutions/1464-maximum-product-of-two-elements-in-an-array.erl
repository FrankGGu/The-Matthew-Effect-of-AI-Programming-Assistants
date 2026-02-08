-module(maximum_product_of_two_elements).
-export([max_product/1]).

max_product(Nums) ->
  lists:foldl(fun(X, {Max1, Max2}) ->
                  if X > Max1 ->
                    {X, Max1};
                  true ->
                    if X > Max2 ->
                      {Max1, X};
                    true ->
                      {Max1, Max2}
                  end
                end, {0, 0}, Nums)
  |> fun({M1, M2}) -> (M1 - 1) * (M2 - 1) end.