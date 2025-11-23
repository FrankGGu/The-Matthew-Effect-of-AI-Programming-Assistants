-module(solution).
-export([num_tuples/1]).

num_tuples(List) ->
    ProductMap = lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc2) -> 
            case X * Y of
                P when P > 0 -> 
                    maps:update_with(P, fun(Count) -> Count + 1 end, 1, Acc2);
                _ -> 
                    Acc2
            end
        end, Acc, List)
    end, maps:new(), List),
    lists:sum(maps:fold(fun(_, Count, Acc) -> 
        Acc + (Count * (Count - 1)) div 2 
    end, 0, ProductMap)).