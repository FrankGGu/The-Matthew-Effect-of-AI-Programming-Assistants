-module(solution).
-export([product_except_self/1]).

product_except_self_left([], _CurrentProduct, Acc) ->
    lists:reverse(Acc);
product_except_self_left([H|T], CurrentProduct, Acc) ->
    product_except_self_left(T, CurrentProduct * H, [CurrentProduct | Acc]).

product_except_self_right([], _CurrentProduct, Acc) ->
    Acc;
product_except_self_right([H|T], CurrentProduct, Acc) ->
    product_except_self_right(T, CurrentProduct * H, [CurrentProduct | Acc]).

product_except_self(Nums) ->
    LeftProducts = product_except_self_left(Nums, 1, []),
    RightProducts = product_except_self_right(lists:reverse(Nums), 1, []),
    lists:zipwith(fun(L, R) -> L * R end, LeftProducts, RightProducts).