-module(longest_alphabetical_continuous_substring).
-export([length_of_longest/1]).

length_of_longest(Str) ->
    length_of_longest(Str, 1, 1, 0).

length_of_longest([], Max, _, _) ->
    Max;
length_of_longest([H | T], Current, Max, Prev) when Prev == 0 ->
    length_of_longest(T, 1, Max, H);
length_of_longest([H | T], Current, Max, Prev) ->
    if
        H == Prev + 1 ->
            length_of_longest(T, Current + 1, max(Max, Current + 1), H);
        true ->
            length_of_longest(T, 1, max(Max, Current), H)
    end.