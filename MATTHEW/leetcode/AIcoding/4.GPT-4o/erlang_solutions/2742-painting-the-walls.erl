-module(painting_the_walls).
-export([min_cost/3]).

min_cost(N, cost, m) ->
    lists:foldl(fun(_, Acc) -> 
        lists:foldl(fun(Prev, Acc1) -> 
            lists:min([Acc1 + cost, Prev + cost]) 
        end, Acc, lists:seq(1, m))
    end, 0, lists:seq(1, N)).