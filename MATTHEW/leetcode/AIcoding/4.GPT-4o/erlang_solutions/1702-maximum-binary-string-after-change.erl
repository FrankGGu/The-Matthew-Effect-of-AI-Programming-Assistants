-module(solution).
-export([maximum_binary_string/1]).

maximum_binary_string(BinaryString) ->
    CountOnes = count_ones(BinaryString),
    Length = length(BinaryString),
    MaxBinaryString = lists:duplicate(CountOnes, $1) ++ lists:duplicate(Length - CountOnes - 1, $0),
    MaxBinaryString.

count_ones(BinaryString) ->
    lists:foldl(fun(Char, Acc) -> Acc + if Char == $1 -> 1; true -> 0 end end, 0, BinaryString).