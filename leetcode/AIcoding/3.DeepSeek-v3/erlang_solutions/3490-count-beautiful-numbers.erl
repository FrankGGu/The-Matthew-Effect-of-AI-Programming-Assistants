-module(solution).
-export([count_beautiful_numbers/1]).

count_beautiful_numbers(N) ->
    count_beautiful_numbers(N, 0).

count_beautiful_numbers(0, Count) ->
    Count;
count_beautiful_numbers(N, Count) ->
    case is_beautiful(N) of
        true -> count_beautiful_numbers(N - 1, Count + 1);
        false -> count_beautiful_numbers(N - 1, Count)
    end.

is_beautiful(N) ->
    Digits = integer_to_list(N),
    Length = length(Digits),
    First = list_to_integer([hd(Digits)]),
    Last = list_to_integer([lists:last(Digits)]),
    (First == Last) and (N rem First == 0).