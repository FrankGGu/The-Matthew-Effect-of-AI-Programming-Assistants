-module(beautiful_array).
-export([beautiful_array/1]).

beautiful_array(N) ->
  beautiful_array_helper(N, [1]).

beautiful_array_helper(1, Acc) ->
  Acc;
beautiful_array_helper(N, Acc) ->
  Odds = [2 * X - 1 || X <- Acc],
  Evens = [2 * X || X <- Acc],
  NewAcc = Odds ++ Evens,
  beautiful_array_helper(N, lists:filter(fun(X) -> X =< N end, NewAcc)).