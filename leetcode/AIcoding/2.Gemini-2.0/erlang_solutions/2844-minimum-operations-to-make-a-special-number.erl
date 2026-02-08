-module(minimum_operations).
-export([minimum_operations/1]).

minimum_operations(Num) ->
    minimum_operations(Num, 0, 0).

minimum_operations(Num, Count, Fives) ->
    minimum_operations(Num, Count, Fives, length(Num) - 1).

minimum_operations(Num, Count, Fives, -1) ->
    if Fives > 0 ->
        Count
    true ->
        length(Num)
    end;
minimum_operations(Num, Count, Fives, Index) ->
    Digit = list_to_integer([lists:nth(Index + 1, string:to_list(Num))]),
    if Digit == 0 ->
        minimum_operations(Num, Count, Fives + 1, Index - 1);
    Digit == 5 ->
        minimum_operations(Num, Count + 1, Fives, Index - 1);
    true ->
        minimum_operations(Num, Count + 1, Fives, Index - 1)
    end.