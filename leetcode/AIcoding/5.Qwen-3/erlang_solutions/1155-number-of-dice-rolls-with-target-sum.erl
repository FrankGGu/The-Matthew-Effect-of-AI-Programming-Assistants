-module(solution).
-export([num_rolls_to_target/2]).

num_rolls_to_target(NumDice, Target) ->
    DP = array:new([{size, NumDice + 1}, {default, 0}]),
    array:set(0, 1, DP),
    num_rolls_to_target(NumDice, Target, DP).

num_rolls_to_target(0, _, DP) ->
    array:get(0, DP);
num_rolls_to_target(N, T, DP) ->
    NewDP = array:new([{size, T + 1}, {default, 0}]),
    lists:foreach(fun(S) -> 
        lists:foreach(fun(R) ->
            if
                S + R =< T ->
                    array:set(S + R, (array:get(S, DP) + array:get(S + R, NewDP)) rem 1000000007, NewDP);
                true ->
                    ok
            end
        end, lists:seq(1, 6))
    end, lists:seq(0, T - 1)),
    num_rolls_to_target(N - 1, T, NewDP).