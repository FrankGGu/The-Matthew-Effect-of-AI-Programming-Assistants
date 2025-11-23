-module(power_of_two).
-export([is_power_of_two/1]).

is_power_of_two(N) when N > 0 -> N band (N - 1) == 0;
is_power_of_two(_) -> false.