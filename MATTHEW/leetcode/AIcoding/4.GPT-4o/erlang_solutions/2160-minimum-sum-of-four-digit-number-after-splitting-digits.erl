-module(solution).
-export([minimum_sum/1]).

minimum_sum(N) ->
    Digits = integer_to_list(N),
    SortedDigits = lists:sort(Digits),
    A1 = list_to_integer([hd(SortedDigits), lists:nth(1, SortedDigits)]),
    A2 = list_to_integer([lists:nth(2, SortedDigits), lists:nth(3, SortedDigits)]),
    A1 + A2.