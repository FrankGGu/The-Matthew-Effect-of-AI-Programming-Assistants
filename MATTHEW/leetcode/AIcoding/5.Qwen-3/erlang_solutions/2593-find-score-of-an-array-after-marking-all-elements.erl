-module(solution).
-export([find_score/1]).

find_score(Nums) ->
    Sorted = lists:sort(Nums),
    Map = maps:from_list([{N, I} || {I, N} <- lists:zip(lists:seq(0, length(Sorted) - 1), Sorted)]),
    Score = 0,
    find_score(Sorted, Map, Score, 0).

find_score([], _, Score, _) -> Score;
find_score([N | Rest], Map, Score, Index) ->
    Count = maps:get(N, Map),
    NewScore = Score + (Index + 1) * Count,
    find_score(Rest, Map, NewScore, Index + 1).