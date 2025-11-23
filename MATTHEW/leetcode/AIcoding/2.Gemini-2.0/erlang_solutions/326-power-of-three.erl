-module(power_of_three).
-export([is_power_of_three/1]).

is_power_of_three(N) ->
    is_power_of_three_helper(N, 1).

is_power_of_three_helper(N, Current) ->
    if Current == N ->
        true;
    Current > N ->
        false;
    true ->
        is_power_of_three_helper(N, Current * 3)
    end.