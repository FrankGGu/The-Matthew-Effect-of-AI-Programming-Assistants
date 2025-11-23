-module(solution).
-export([maxPoints/2]).

maxPoints(Matrix, Cost) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    Points = lists:foldl(fun(X, Acc) -> lists:map(fun(Y) -> X + Y end, Acc) end, lists:duplicate(M, 0), Matrix),
    lists:foldl(fun(_, Acc) -> lists:map(fun({C, P}) -> max(P, lists:nth(C + 1, Acc) - Cost) end, Acc) end, Points, lists:seq(1, N - 1)).