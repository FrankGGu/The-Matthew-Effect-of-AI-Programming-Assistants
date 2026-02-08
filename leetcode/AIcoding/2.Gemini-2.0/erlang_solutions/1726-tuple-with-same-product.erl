-module(tuple_with_same_product).
-export([tuple_same_product/1]).

tuple_same_product(Nums) ->
  tuple_same_product(Nums, 0, maps:new()).

tuple_same_product([], Acc, _) ->
  Acc;
tuple_same_product([H | T], Acc, Products) ->
  tuple_same_product(T, tuple_same_product(H, T, Acc, Products), Products).

tuple_same_product(_, [], Acc, _) ->
  Acc;
tuple_same_product(H1, [H2 | T], Acc, Products) ->
  Product = H1 * H2,
  NewAcc =
    case maps:is_key(Product, Products) of
      true ->
        Acc + maps:get(Product, Products) * 8;
      false ->
        Acc
    end,
  NewProducts =
    case maps:is_key(Product, Products) of
      true ->
        maps:update(Product, maps:get(Product, Products) + 1, Products);
      false ->
        maps:put(Product, 1, Products)
    end,
  tuple_same_product(H1, T, NewAcc, NewProducts).