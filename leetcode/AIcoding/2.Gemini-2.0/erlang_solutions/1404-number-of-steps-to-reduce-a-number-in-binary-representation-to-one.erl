-module(number_of_steps).
-export([num_steps/1]).

num_steps(S) ->
  num_steps_helper(list_to_integer([X - $0 || X <- S]), 0).

num_steps_helper(1, Steps) ->
  Steps;
num_steps_helper(N, Steps) ->
  if
    N rem 2 == 0 ->
      num_steps_helper(N div 2, Steps + 1);
    true ->
      num_steps_helper(N + 1, Steps + 1)
  end.