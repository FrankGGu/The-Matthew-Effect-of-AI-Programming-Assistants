-module(max_diff_adjacent).
-export([maxAdjacentDifference/1]).

maxAdjacentDifference(Nums) ->
    N = length(Nums),
    if
        N < 2 -> -1;
        true ->
            MaxDiff = lists:foldl(fun(I, Acc) ->
                J = (I + 1) rem N,
                Diff = abs(lists:nth(I + 1, Nums) - lists:nth(J + 1, Nums)),
                max(Acc, Diff)
            end, -1, lists:seq(0, N - 1))
    end.