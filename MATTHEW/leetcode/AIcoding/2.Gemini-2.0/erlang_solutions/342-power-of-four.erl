-module(power_of_four).
-export([is_power_of_four/1]).

is_power_of_four(N) ->
  case N > 0 of
    true ->
      (N band (N - 1)) == 0 andalso (N band 1431655765) == N;
    false ->
      false
  end.