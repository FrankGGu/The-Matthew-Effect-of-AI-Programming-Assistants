-module(path_with_minimum_effort).
-export([minimumEffortPath/1]).

minimumEffortPath(Heights) ->
  Rows = length(Heights),
  Cols = length(hd(Heights)),
  Dist = array:new([{default, infinity}]),
  array:set({0,0}, 0, Dist),
  PriorityQueue = gb_sets:add({0, {0,0}}, gb_sets:empty()),

  minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue).

minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue) ->
  case gb_sets:is_empty(PriorityQueue) of
    true ->
      array:get({Rows-1, Cols-1}, Dist);
    false ->
      {_, {Effort, {Row, Col}}} = gb_sets:smallest(PriorityQueue),
      PriorityQueue1 = gb_sets:delete({Effort, {Row, Col}}, PriorityQueue),

      Neighbors = get_neighbors(Row, Col, Rows, Cols),
      minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue1, Neighbors, Heights).

minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue, [], _) ->
  minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue);
minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue, [{NewRow, NewCol} | Rest], Heights) ->
  Rows1 = length(Heights),
  Cols1 = length(hd(Heights)),

  {ok, Height} = array:lookup({NewRow, NewCol}, array:from_list(lists:flatten(Heights))),

  {ok, CurrentHeight} = array:lookup({Row, Col}, array:from_list(lists:flatten(Heights))),

  Effort = max(array:get({Row, Col}, Dist), abs(Height - CurrentHeight)),

  if Effort < array:get({NewRow, NewCol}, Dist) ->
    array:set({NewRow, NewCol}, Effort, Dist),
    PriorityQueue1 = gb_sets:add({Effort, {NewRow, NewCol}}, PriorityQueue),
    minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue1, Rest, Heights);
  true ->
    minimumEffortPath(Heights, Rows, Cols, Dist, PriorityQueue, Rest, Heights)
  end.

get_neighbors(Row, Col, Rows, Cols) ->
  Neighbors = [],
  Neighbors1 =
    if Row > 0 ->
      [{Row-1, Col} | Neighbors]
    else
      Neighbors
    end,
  Neighbors2 =
    if Row < Rows - 1 ->
      [{Row+1, Col} | Neighbors1]
    else
      Neighbors1
    end,
  Neighbors3 =
    if Col > 0 ->
      [{Row, Col-1} | Neighbors2]
    else
      Neighbors2
    end,
  if Col < Cols - 1 ->
    [{Row, Col+1} | Neighbors3]
  else
    Neighbors3
  end.