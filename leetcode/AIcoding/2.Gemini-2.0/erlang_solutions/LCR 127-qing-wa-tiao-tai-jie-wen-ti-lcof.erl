-module(jump_training).
-export([max_altitude/1]).

max_altitude(heights) ->
  lists:foldl(fun(H, {Max, Prev}) ->
                  Diff = H - Prev,
                  NewMax = max(Max, Diff),
                  {NewMax, H}
              end, {0, lists:nth(1, heights)}, lists:nthtail(1, heights)) || {0,0}.