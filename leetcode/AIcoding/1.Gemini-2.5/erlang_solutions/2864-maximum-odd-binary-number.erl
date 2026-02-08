-module(solution).
-export([maximum_odd_binary_number/1]).

maximum_odd_binary_number(S) ->
    Len = string:len(S),
    Ones = lists:foldl(fun(C, Acc) -> if C == $1 -> Acc + 1; true -> Acc end end, 0, S),
    Zeros = Len - Ones,

    LeadingOnes = Ones - 1,

    lists:duplicate(LeadingOnes, $1) ++ lists:duplicate(Zeros, $0) ++ [$1].