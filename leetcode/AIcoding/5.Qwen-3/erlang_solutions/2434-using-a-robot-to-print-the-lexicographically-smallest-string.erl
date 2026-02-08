-module(solution).
-export([robotWithString/1]).

robotWithString(S) ->
    robotWithString(S, [], 0).

robotWithString([], Stack, _) ->
    lists:reverse(Stack);
robotWithString(S, Stack, Pos) ->
    [C | Rest] = S,
    if
        Pos == length(S) ->
            lists:reverse(Stack);
        true ->
            robotWithString(Rest, [C | Stack], Pos + 1)
    end.