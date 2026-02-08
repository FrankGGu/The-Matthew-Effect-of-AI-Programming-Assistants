-module(power_of_two).
-export([is_power_of_two/1]).

is_power_of_two(N) ->
  N > 0 andalso (N band (N - 1)) == 0.