-module(solution).
-export([min_steps/1]).

min_steps(N) ->
  min_steps_helper(N, 2).

min_steps_helper(N, I) when I * I > N ->
  N.
min_steps_helper(N, I) when N rem I == 0 ->
  I + min_steps_helper(N div I, I);
min_steps_helper(N, I) ->
  min_steps_helper(N, I + 1).