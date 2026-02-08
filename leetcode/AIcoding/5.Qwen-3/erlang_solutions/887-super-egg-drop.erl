-module(solve).
-export([super_egg_drop/2]).

super_egg_drop(N, K) ->
    super_egg_drop(N, K, 1, 0).

super_egg_drop(1, _, _, Acc) ->
    Acc;
super_egg_drop(N, K, Steps, Acc) ->
    NewAcc = Acc + math:pow(2, Steps),
    if
        NewAcc >= K ->
            Steps;
        true ->
            super_egg_drop(N, K, Steps + 1, NewAcc)
    end.