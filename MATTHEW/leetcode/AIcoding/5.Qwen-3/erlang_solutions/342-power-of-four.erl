-module(power_of_four).
-export([is_power_of_four/1]).

is_power_of_four(N) when N =< 0 -> false;
is_power_of_four(N) ->
    (N band (N - 1)) == 0 andalso (N rem 3) == 1.