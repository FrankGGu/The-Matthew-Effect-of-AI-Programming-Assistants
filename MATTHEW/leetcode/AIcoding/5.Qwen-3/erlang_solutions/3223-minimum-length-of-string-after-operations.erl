-module(minimum_length_of_string_after_operations).
-export([minimumLength/1]).

minimumLength(S) ->
    minimumLength(S, 0, 0).

minimumLength([], _, _) ->
    0;
minimumLength([H | T], Count, LastChar) ->
    if
        H == LastChar ->
            minimumLength(T, Count + 1, H);
        true ->
            minimumLength(T, Count, H)
    end.