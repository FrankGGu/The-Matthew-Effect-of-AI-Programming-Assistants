-module(solution).
-export([count_stepping_numbers/2]).

count_stepping_numbers(Start, End) ->
    count_stepping_numbers(Start, End, 0).

count_stepping_numbers(Start, End, Count) when Start > End ->
    Count;
count_stepping_numbers(Start, End, Count) ->
    case is_stepping_number(Start) of
        true -> count_stepping_numbers(Start + 1, End, Count + 1);
        false -> count_stepping_numbers(Start + 1, End, Count)
    end.

is_stepping_number(N) when N < 0 ->
    false;
is_stepping_number(N) when N < 10 ->
    true;
is_stepping_number(N) ->
    is_stepping_number(N, 0).

is_stepping_number(0, _) ->
    true;
is_stepping_number(N, Prev) ->
    Current = N rem 10,
    if
        Prev == 0 ->
            is_stepping_number(N div 10, Current);
        abs(Current - Prev) == 1 ->
            is_stepping_number(N div 10, Current);
        true ->
            false
    end.