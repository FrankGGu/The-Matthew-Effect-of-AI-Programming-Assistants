-module(solution).
-export([count_houses/3]).

count_houses(N, houses, distance) ->
    lists:foldl(fun(H, Acc) -> 
        Acc + count_at_distance(H, distance, houses) 
    end, 0, lists:seq(1, N)).

count_at_distance(H, D, Houses) ->
    lists:foldl(fun(X, Acc) ->
        if 
            X =:= H + D orelse X =:= H - D -> Acc + 1;
            true -> Acc
        end
    end, 0, Houses).