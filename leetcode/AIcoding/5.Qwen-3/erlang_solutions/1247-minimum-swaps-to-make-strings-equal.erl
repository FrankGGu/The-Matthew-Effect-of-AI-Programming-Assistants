-module(minimum_swaps).
-export([min_swaps/2]).

min_swaps(A, B) ->
    Count = lists:foldl(fun(C, Acc) -> 
        case lists:keyfind(C, 1, Acc) of
            false -> [{C, 1} | Acc];
            {C, N} -> lists:keystore(C, 1, Acc, {C, N + 1})
        end
    end, [], A ++ B),
    Pairs = lists:filter(fun({_, N}) -> N > 1 end, Count),
    PairsCount = length(Pairs),
    if
        PairsCount == 0 -> 0;
        true -> (PairsCount * 2) div 3
    end.