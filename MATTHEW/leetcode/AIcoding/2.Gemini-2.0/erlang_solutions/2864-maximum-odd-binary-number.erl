-module(maximum_odd_binary_number).
-export([maximum_odd_binary_number/1]).

maximum_odd_binary_number(S) ->
    Ones = lists:foldl(fun(C, Acc) -> if C == '1' -> Acc + 1; true -> Acc end end, 0, S),
    Zeros = length(S) - Ones,
    lists:concat([lists:duplicate(Ones - 1, $1), lists:duplicate(Zeros, $0), [$1]]).