-module(building_boxes).
-export([min_boxes/1]).

min_boxes(N) ->
  min_boxes_helper(N, 0, 0, 0).

min_boxes_helper(0, Level, Boxes, Sum) ->
  Boxes;
min_boxes_helper(N, Level, Boxes, Sum) ->
  NextLevel = Level + 1,
  NextSum = Sum + NextLevel,
  case N >= NextSum of
    true ->
      min_boxes_helper(N - NextSum, NextLevel, Boxes + NextLevel, NextSum);
    false ->
      find_boxes(N, Level, Boxes, Sum)
  end.

find_boxes(N, Level, Boxes, Sum) ->
  find_boxes_helper(N, Level, Boxes, Sum, Level).

find_boxes_helper(0, _, Boxes, _, _) ->
  Boxes;
find_boxes_helper(N, Level, Boxes, Sum, CurrentLevel) when CurrentLevel > 0 ->
  case N >= CurrentLevel of
    true ->
      find_boxes_helper(N - CurrentLevel, Level, Boxes + 1, Sum, CurrentLevel - 1);
    false ->
      find_boxes_helper(N, Level, Boxes, Sum, CurrentLevel - 1)
  end;
find_boxes_helper(_, _, Boxes, _, _) ->
  Boxes.