-module(solution).
-export([maximum_odd_binary_number/1]).

maximum_odd_binary_number(Binary) ->
    CountZeros = length(lists:filter(fun(X) -> X =:= $0 end, Binary)),
    Ones = lists:filter(fun(X) -> X =:= $1 end, Binary),
    OnesString = lists:duplicate(length(Ones), $1),
    OddBinary = OnesString ++ [$1] ++ lists:duplicate(CountZeros, $0),
    lists:flatten(OddBinary).