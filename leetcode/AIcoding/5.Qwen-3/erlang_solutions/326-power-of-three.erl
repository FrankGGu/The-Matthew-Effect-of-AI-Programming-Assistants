-module(power_of_three).
-export([is_power_of_three/1]).

is_power_of_three(N) ->
    is_power_of_three(N, 1).

is_power_of_three(N, Power) when Power > N ->
    false;
is_power_of_three(N, Power) when Power == N ->
    true;
is_power_of_three(N, Power) ->
    is_power_of_three(N, Power * 3).