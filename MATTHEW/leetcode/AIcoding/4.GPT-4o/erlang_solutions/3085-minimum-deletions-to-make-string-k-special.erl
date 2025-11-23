-module(solution).
-export([minimum_deletions/2]).

minimum_deletions(S, K) ->
    Count = length(S),
    CharCounts = lists:foldl(fun(C, Acc) -> 
        maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) 
    end, map:new(), S),
    Frequencies = maps:to_list(CharCounts),
    SortedFrequencies = lists:sort(fun({_, A}, {_, B}) -> A > B end, Frequencies),
    case length(SortedFrequencies) of
        N when N =< K -> 0;
        _ -> lists:sum(lists:map(fun({_, F}) -> F end, lists:drop(K, SortedFrequencies)))
    end.