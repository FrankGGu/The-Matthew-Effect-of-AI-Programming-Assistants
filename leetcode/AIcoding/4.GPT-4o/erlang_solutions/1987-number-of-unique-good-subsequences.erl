-module(solution).
-export([number_of_unique_good_subsequences/1]).

number_of_unique_good_subsequences(BinaryString) ->
    Count = length(BinaryString),
    HasZero = lists:any(fun(X) -> X =:= $0 end, BinaryString),
    LastOne = lists:last(BinaryString, $0),
    UniqueCount = if
        HasZero -> 
            Count - 1;
        true -> 
            Count
    end,
    if
        LastOne =:= $1 -> 
            UniqueCount + 1;
        true -> 
            UniqueCount
    end rem 1000000007.