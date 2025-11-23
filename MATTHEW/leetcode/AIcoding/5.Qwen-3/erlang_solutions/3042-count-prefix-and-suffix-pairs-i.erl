-module(solution).
-export([prefix_suffix_pairs/1]).

prefix_suffix_pairs(Words) ->
    Count = 0,
    lists:foldl(fun(W, Acc) -> 
        lists:foldl(fun(W2, Acc2) -> 
            if W == W2 -> Acc2 + 1;
               true -> Acc2
            end
        end, Acc, Words)
    end, Count, Words).