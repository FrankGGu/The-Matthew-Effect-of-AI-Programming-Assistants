-module(solution).
-export([product_except_self/1]).

product_except_self(Nums) ->
    N = length(Nums),
    Result = lists:duplicate(N, 1),
    Left = lists:seq(0, N-1),
    Right = lists:seq(N-1, 0, -1),
    LeftProduct = product_helper(Left, 1, []),
    RightProduct = product_helper(Right, 1, []),
    lists:zipwith(fun(L, R) -> L * R end, LeftProduct, RightProduct).

product_helper([], _, Acc) ->
    lists:reverse(Acc);
product_helper([H | T], AccVal, Acc) ->
    product_helper(T, AccVal * lists:nth(H+1, lists:seq(1, length(lists:seq(1, length(Nums))))), [AccVal | Acc]).