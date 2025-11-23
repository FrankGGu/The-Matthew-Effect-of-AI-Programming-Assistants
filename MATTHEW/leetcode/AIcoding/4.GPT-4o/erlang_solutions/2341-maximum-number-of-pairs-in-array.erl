-module(solution).
-export([maximum_pairs/1]).

maximum_pairs(Array) ->
    Pairs = lists:foldl(fun(X, Acc) -> 
        case maps:find(X, Acc) of
            {ok, Count} -> maps:update(X, Count + 1, Acc);
            _ -> maps:put(X, 1, Acc)
        end
    end, #{}, Array),
    lists:foldl(fun({_Key, Count}, {PairsCount, SinglesCount}) -> 
        {PairsCount + Count div 2, SinglesCount + Count rem 2} 
    end, {0, 0}, maps:to_list(Pairs).