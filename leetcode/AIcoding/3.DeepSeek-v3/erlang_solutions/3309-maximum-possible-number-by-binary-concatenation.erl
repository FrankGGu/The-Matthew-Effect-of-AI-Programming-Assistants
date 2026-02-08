-module(solution).
-export([maximum_binary_string/1]).

maximum_binary_string(Binary) ->
    L = binary_to_list(Binary),
    case lists:member($0, L) of
        false -> Binary;
        true ->
            Zeros = lists:filter(fun(C) -> C == $0 end, L),
            Ones = lists:filter(fun(C) -> C == $1 end, L),
            NumZeros = length(Zeros),
            NumOnes = length(Ones),
            Result = lists:duplicate(NumZeros - 1, $1) ++ "0" ++ lists:duplicate(NumOnes, $1),
            list_to_binary(Result)
    end.