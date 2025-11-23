-module(number_of_boomerangs).
-export([num_boomerangs/1]).

num_boomerangs(Points) ->
    Maps = lists:foldl(fun(P, Acc) ->
        X = element(1, P),
        Y = element(2, P),
        DistMap = maps:get({X, Y}, Acc, #{}),
        lists:foreach(fun({Q, _}) ->
            DX = element(1, Q) - X,
            DY = element(2, Q) - Y,
            Dist = DX * DX + DY * DY,
            Count = maps:get(Dist, DistMap, 0) + 1,
            NewDistMap = maps:put(Dist, Count, DistMap),
            maps:put({X, Y}, NewDistMap, Acc)
        end, Points),
        Acc
    end, #{}, Points),
    lists:foldl(fun({_K, DistMap}, Acc) ->
        Total = maps:fold(fun(_D, C, T) -> T + C end, 0, DistMap),
        Acc + Total
    end, 0, Maps).