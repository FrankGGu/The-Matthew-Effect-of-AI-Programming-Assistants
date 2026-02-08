-module(solution).
-export([min_time/1]).

min_time(BinaryString) ->
    Ones = length(lists:filter(fun(X) -> X =:= $1 end, string:to_list(BinaryString))),
    Zeros = length(lists:filter(fun(X) -> X =:= $0 end, string:to_list(BinaryString))),
    max(Ones, Zeros).