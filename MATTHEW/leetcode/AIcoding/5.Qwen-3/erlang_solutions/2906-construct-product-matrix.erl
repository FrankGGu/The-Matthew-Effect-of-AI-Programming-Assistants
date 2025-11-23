-module(solution).
-export([productExceptSelf/1]).

productExceptSelf(Nums) ->
    N = length(Nums),
    Left = lists:seq(0, N-1),
    Right = lists:seq(0, N-1),
    LeftProduct = product(Left, Nums, 1, []),
    RightProduct = product(Right, Nums, 1, []),
    lists:zipwith(fun(L, R) -> L * R end, LeftProduct, RightProduct).

product([], _, _, Acc) ->
    lists:reverse(Acc);
product([I | T], Nums, AccVal, Acc) ->
    Val = lists:nth(I + 1, Nums),
    product(T, Nums, AccVal * Val, [AccVal | Acc]).