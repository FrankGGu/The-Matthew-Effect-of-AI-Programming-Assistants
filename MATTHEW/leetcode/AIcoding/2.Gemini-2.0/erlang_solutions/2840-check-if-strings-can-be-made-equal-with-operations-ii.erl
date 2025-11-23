-module(solution).
-export([can_be_equal/2]).

can_be_equal(S1, S2) ->
  S1_odd = lists:sort([C || {I, C} <- lists:zip(lists:seq(1, length(S1)), string:to_list(S1)), I rem 2 =:= 1]),
  S2_odd = lists:sort([C || {I, C} <- lists:zip(lists:seq(1, length(S2)), string:to_list(S2)), I rem 2 =:= 1]),
  S1_even = lists:sort([C || {I, C} <- lists:zip(lists:seq(1, length(S1)), string:to_list(S1)), I rem 2 =:= 0]),
  S2_even = lists:sort([C || {I, C} <- lists:zip(lists:seq(1, length(S2)), string:to_list(S2)), I rem 2 =:= 0]),
  S1_odd =:= S2_odd andalso S1_even =:= S2_even.