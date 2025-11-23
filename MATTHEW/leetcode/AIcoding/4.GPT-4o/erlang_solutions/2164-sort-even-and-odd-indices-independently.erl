-module(solution).
-export([sort_even_odd_indices/1]).

sort_even_odd_indices(List) ->
    EvenIndices = lists:filter(fun({Index, _}) -> Index rem 2 == 0 end, lists:zip(lists:seq(0, length(List) - 1), List)),
    OddIndices = lists:filter(fun({Index, _}) -> Index rem 2 == 1 end, lists:zip(lists:seq(0, length(List) - 1), List)),
    SortedEvens = lists:map(fun({_, Value}) -> Value end, lists:sort(fun({_, A}, {_, B}) -> A < B end, EvenIndices)),
    SortedOdds = lists:map(fun({_, Value}) -> Value end, lists:sort(fun({_, A}, {_, B}) -> A < B end, OddIndices)),
    lists:map(fun(Index) -> 
        case Index rem 2 of 
            0 -> lists:nth((Index div 2) + 1, SortedEvens);
            1 -> lists:nth((Index div 2) + 1, SortedOdds)
        end 
    end, lists:seq(0, length(List) - 1)).