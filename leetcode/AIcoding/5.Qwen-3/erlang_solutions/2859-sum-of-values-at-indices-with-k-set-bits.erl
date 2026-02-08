-module(solution).
-export([sumIndicesWithK/1]).

sumIndicesWithK(Nums) ->
    sumIndicesWithK(Nums, 0, 0, 0).

sumIndicesWithK([], _, _, Acc) ->
    Acc;
sumIndicesWithK([H|T], Index, K, Acc) ->
    case countSetBits(Index) of
        K -> sumIndicesWithK(T, Index + 1, K, Acc + H);
        _ -> sumIndicesWithK(T, Index + 1, K, Acc)
    end.

countSetBits(N) ->
    countSetBits(N, 0).

countSetBits(0, Count) ->
    Count;
countSetBits(N, Count) ->
    countSetBits(N band (N - 1), Count + 1).