-module(solution).
-export([find_score/1]).

find_score(Nums) ->
    N = length(Nums),
    IndexedNums = lists:zip(Nums, lists:seq(0, N-1)),
    SortedIndexedNums = lists:sort(fun({V1, _}, {V2, _}) -> V1 =< V2 end, IndexedNums),
    MarkedArray = array:new(N, {default, false}),
    calculate_score(SortedIndexedNums, MarkedArray, 0, N).

calculate_score([], _MarkedArray, CurrentScore, _N) ->
    CurrentScore;
calculate_score([{V, I} | Rest], MarkedArray, CurrentScore, N) ->
    case array:get(I, MarkedArray) of
        true ->
            calculate_score(Rest, MarkedArray, CurrentScore, N);
        false ->
            NewScore = CurrentScore + V,
            MarkedArray1 = array:set(I, true, MarkedArray),
            MarkedArray2 = if I > 0 -> array:set(I-1, true, MarkedArray1); true -> MarkedArray1 end,
            MarkedArray3 = if I < N-1 -> array:set(I+1, true, MarkedArray2); true -> MarkedArray2 end,
            calculate_score(Rest, MarkedArray3, NewScore, N)
    end.