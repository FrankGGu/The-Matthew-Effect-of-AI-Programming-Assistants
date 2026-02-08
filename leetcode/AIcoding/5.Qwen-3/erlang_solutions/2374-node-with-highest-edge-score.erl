-module(highest_edge_score).
-export([maxNode/1]).

maxNode(Scores) ->
    Max = lists:max(Scores),
    find_first_index(Scores, Max, 0).

find_first_index([], _, _) ->
    0;
find_first_index([H | T], Target, Index) ->
    if
        H == Target ->
            Index;
        true ->
            find_first_index(T, Target, Index + 1)
    end.