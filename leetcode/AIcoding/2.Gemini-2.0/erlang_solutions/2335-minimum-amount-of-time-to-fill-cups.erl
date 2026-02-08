-module(minimum_time_to_fill_cups).
-export([minimum_time/1]).

minimum_time([A, B, C]) ->
  lists:sort([A, B, C], fun(X, Y) -> X > Y end) ->
  [Max, Mid, Min] = lists:sort([A, B, C], fun(X, Y) -> X > Y end),
  if
    Max > Mid + Min ->
      Max;
    true ->
      (A + B + C + 1) div 2
  end.