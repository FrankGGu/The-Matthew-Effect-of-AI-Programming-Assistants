-module(solution).
-export([min_pair_removals/1]).

min_pair_removals(List) ->
    Sorted = lists:sort(List),
    Length = length(List),
    Count = count_pairs(List),
    Length - Count.

count_pairs(List) ->
    Count = lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of 
            true -> 
                Acc;
            false -> 
                [X | Acc]
        end 
    end, [], List),
    length(Count).