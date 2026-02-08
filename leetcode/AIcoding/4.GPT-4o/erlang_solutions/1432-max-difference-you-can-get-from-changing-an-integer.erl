-module(solution).
-export([maximum_difference/1]).

maximum_difference(N) ->
    {Min, Max} = get_min_max_digits(N),
    Max - Min.

get_min_max_digits(N) ->
    Digits = integer_to_list(N),
    MinDigits = lists:map(fun(D) -> if D =:= $9 -> $0; true -> D end end, Digits),
    MaxDigits = lists:map(fun(D) -> if D =:= $0 -> $9; true -> D end end, Digits),
    {list_to_integer(MinDigits), list_to_integer(MaxDigits)}.