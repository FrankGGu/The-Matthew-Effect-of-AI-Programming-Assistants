-module(solution).
-export([maximumBinaryString/1]).

maximumBinaryString(BinaryString) ->
    N = length(BinaryString),
    NumZeros = lists:foldl(fun(C, Acc) -> if C == $0 -> Acc + 1; true -> Acc end end, 0, BinaryString),

    if
        NumZeros == 0 ->
            BinaryString;
        true ->
            string:duplicate(N - 1, $1) ++ [$0]
    end.