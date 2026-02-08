-module(solution).
-export([find_subarrays/1]).

find_subarrays(List) ->
    Length = length(List),
    SubArrays = lists:foldl(fun(_, Acc) -> 
        [lists:sublist(List, Start, 2) || Start <- lists:seq(0, Length - 2)] ++ Acc 
    end, [], List),
    UniqueSums = lists:usort(lists:map(fun(Sub) -> lists:sum(Sub) end, SubArrays)),
    lists:filter(fun(Sum) -> lists:count(SubArrays, lists:filter(fun(X) -> lists:sum(X) =:= Sum end, SubArrays)) > 1 end, UniqueSums).