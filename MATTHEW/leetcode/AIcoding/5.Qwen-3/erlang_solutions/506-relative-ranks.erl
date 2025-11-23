-module(relative_ranks).
-export([find_relative_ranks/1]).

find_relative_ranks(Scores) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Scores),
    Map = maps:from_list([{Score, index(Sorted, Score)} || Score <- Sorted]),
    lists:map(fun(Score) -> rank_to_string(Map#{}(Score)) end, Scores).

index(List, Elem) ->
    index(List, Elem, 1).

index([], _, _) ->
    error;
index([H | T], Elem, N) when H == Elem ->
    N;
index([_ | T], Elem, N) ->
    index(T, Elem, N + 1).

rank_to_string(1) -> "Gold Medal";
rank_to_string(2) -> "Silver Medal";
rank_to_string(3) -> "Bronze Medal";
rank_to_string(N) -> integer_to_list(N).