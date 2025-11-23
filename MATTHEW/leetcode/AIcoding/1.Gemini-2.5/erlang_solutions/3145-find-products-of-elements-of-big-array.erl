-module(solution).
-export([find_products/1]).

find_products(Nums) ->
    LeftProducts = calculate_left_products(Nums),
    RightProducts = calculate_right_products(Nums),

    lists:zipwith(fun(L, R) -> L * R end, LeftProducts, RightProducts).

calculate_left_products(Nums) ->
    calculate_left_products_acc(Nums, 1, []).

calculate_left_products_acc([], _CurrentProduct, Acc) ->
    lists:reverse(Acc).
calculate_left_products_acc([H|T], CurrentProduct, Acc) ->
    calculate_left_products_acc(T, CurrentProduct * H, [CurrentProduct | Acc]).

calculate_right_products(Nums) ->
    ReversedNums = lists:reverse(Nums),
    ReversedLeftProducts = calculate_left_products_acc(ReversedNums, 1, []),
    lists:reverse(ReversedLeftProducts).