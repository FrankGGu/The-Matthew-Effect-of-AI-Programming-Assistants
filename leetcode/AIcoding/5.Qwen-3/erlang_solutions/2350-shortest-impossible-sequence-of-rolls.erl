-module(solution).
-export([shortest_subarray/1]).

shortest_subarray(Rolls) ->
    Max = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, Rolls),
    Seen = sets:from_list(Rolls),
    find_missing(1, Max, Seen).

find_missing(N, Max, _) when N > Max ->
    Max + 1;
find_missing(N, Max, Seen) ->
    case sets:is_element(N, Seen) of
        true ->
            find_missing(N + 1, Max, Seen);
        false ->
            N
    end.