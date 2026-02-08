-module(solution).
-export([append_characters/2]).

append_characters(S, T) ->
    append_characters(S, T, 0, 0).

append_characters(_, _, I, J) when J == length(T) ->
    0;
append_characters(S, T, I, J) when I == length(S) ->
    length(T) - J;
append_characters(S, T, I, J) ->
    if
        lists:nth(I + 1, S) == lists:nth(J + 1, T) ->
            append_characters(S, T, I + 1, J + 1);
        true ->
            append_characters(S, T, I + 1, J)
    end.