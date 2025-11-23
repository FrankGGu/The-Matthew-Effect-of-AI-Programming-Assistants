-module(solution).
-export([max_length/1]).

max_length(Str) ->
    max_length(Str, #{}).

max_length(Str, Visited) ->
    max_length(Str, Visited, 0, 0, length(Str)).

max_length([], _, Max, _, _) -> Max;
max_length([H | T], Visited, Max, Start, Length) ->
    case maps:is_key(H, Visited) of
        true ->
            NewMax = max(Max, Length - Start - 1),
            max_length(T, maps:remove(H, Visited), NewMax, Start + 1, Length);
        false ->
            max_length(T, maps:put(H, Start, Visited), Max, Start, Length)
    end.