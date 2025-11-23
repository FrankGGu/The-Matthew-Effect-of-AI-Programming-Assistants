-module(solution).
-export([min_length/1]).

min_length(Numbers) ->
    min_length(Numbers, 1).

min_length([], _) ->
    0;
min_length([H | T], N) ->
    case lists:member(H, T) of
        true ->
            min_length(T, N + 1);
        false ->
            min_length(T, N)
    end.