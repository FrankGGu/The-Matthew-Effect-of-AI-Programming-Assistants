-module(min_length).
-export([min_length/1]).

min_length(S) ->
    min_length(S, 0, string:length(S) - 1).

min_length(S, L, R) when L > R ->
    R - L + 1;
min_length(S, L, R) ->
    case string:substr(S, L + 1, 1) == string:substr(S, R + 1, 1) of
        true ->
            Char = string:substr(S, L + 1, 1),
            {NewL, NewR} = trim(S, L, R, Char),
            min_length(S, NewL, NewR);
        false ->
            R - L + 1
    end.

trim(S, L, R, Char) ->
    {trim_left(S, L, R, Char), trim_right(S, L, R, Char)}.

trim_left(S, L, R, Char) when L > R ->
    L;
trim_left(S, L, R, Char) ->
    case string:substr(S, L + 1, 1) == Char of
        true ->
            trim_left(S, L + 1, R, Char);
        false ->
            L
    end.

trim_right(S, L, R, Char) when L > R ->
    R;
trim_right(S, L, R, Char) ->
    case string:substr(S, R + 1, 1) == Char of
        true ->
            trim_right(S, L, R - 1, Char);
        false ->
            R
    end.