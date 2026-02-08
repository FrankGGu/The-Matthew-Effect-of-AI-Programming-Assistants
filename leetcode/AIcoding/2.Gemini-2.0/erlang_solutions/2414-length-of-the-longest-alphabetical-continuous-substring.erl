-module(longest_alphabetical_substring).
-export([max_length_between_equal_characters/1]).

max_length_between_equal_characters(S) ->
    max_length_between_equal_characters(S, 0, 0, []).

max_length_between_equal_characters([], MaxLength, _, _) ->
    MaxLength;
max_length_between_equal_characters([H|T], MaxLength, CurrentLength, Prev) ->
    case Prev of
        [] ->
            max_length_between_equal_characters(T, MaxLength, 1, [H]);
        [LastChar] ->
            if H == LastChar + 1 ->
                max_length_between_equal_characters(T, max(MaxLength, CurrentLength + 1), CurrentLength + 1, [H]);
            true ->
                max_length_between_equal_characters(T, max(MaxLength, 1), 1, [H])
            end
    end.