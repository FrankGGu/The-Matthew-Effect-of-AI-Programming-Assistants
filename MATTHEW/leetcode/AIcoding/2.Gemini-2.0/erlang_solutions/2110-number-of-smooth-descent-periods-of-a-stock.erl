-module(smooth_descent).
-export([get_descent_periods/1]).

get_descent_periods(Prices) ->
  get_descent_periods(Prices, 0, 1).

get_descent_periods([], Acc, _) ->
  Acc;
get_descent_periods([_], Acc, _) ->
  Acc + 1;
get_descent_periods([H1, H2 | T], Acc, Count) ->
  if
    H1 - H2 == 1 ->
      get_descent_periods([H2 | T], Acc + Count + 1, Count + 1);
    true ->
      get_descent_periods([H2 | T], Acc + 1, 1)
  end.