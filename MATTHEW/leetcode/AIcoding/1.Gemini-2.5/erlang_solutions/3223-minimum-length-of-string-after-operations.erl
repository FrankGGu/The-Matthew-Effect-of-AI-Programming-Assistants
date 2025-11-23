-module(solution).
-export([minimum_length/1]).

-spec minimum_length(S_binary :: unicode:unicode_binary()) -> integer().
minimum_length(S_binary) ->
    Len = binary:size(S_binary),
    minimum_length_recursive(S_binary, 0, Len - 1).

minimum_length_recursive(S_binary, L, R) ->
    if
        L > R ->
            0;
        L == R ->
            1;
        binary:at(S_binary, L) == binary:at(S_binary, R) ->
            Char = binary:at(S_binary, L),
            NewL = advance_left(S_binary, L, R, Char),
            NewR = advance_right(S_binary, L, R, Char),
            minimum_length_recursive(S_binary, NewL, NewR);
        true ->
            R - L + 1
    end.

advance_left(S_binary, L, R, Char) ->
    if
        L <= R andalso binary:at(S_binary, L) == Char ->
            advance_left(S_binary, L + 1, R, Char);
        true ->
            L
    end.

advance_right(S_binary, L, R, Char) ->
    if
        L <= R andalso binary:at(S_binary, R) == Char ->
            advance_right(S_binary, L, R - 1, Char);
        true ->
            R
    end.