-module(cut_off_trees).
-export([cut_off_tree/1]).

cut_off_tree(forest) ->
  {Rows, Cols} = {length(forest), length(hd(forest))},
  Trees = get_trees(forest, Rows, Cols),
  sorted_trees(Trees, forest, Rows, Cols).

get_trees(Forest, Rows, Cols) ->
  get_trees(Forest, Rows, Cols, 0, 0, []).

get_trees(_Forest, Rows, _Cols, Rows, _Col, Acc) ->
  Acc;
get_trees(Forest, Rows, Cols, Row, Col, Acc) ->
  Val = lists:nth(Row+1, Forest),
  TreeVal = lists:nth(Col+1, Val),
  case TreeVal > 1 of
    true ->
      get_trees(Forest, Rows, Cols, Row, Col+1, [{TreeVal, Row, Col}|Acc]);
    false ->
      get_trees(Forest, Rows, Cols, Row, Col+1, Acc)
  end.

sorted_trees([], _Forest, _Rows, _Cols) ->
  0;
sorted_trees(Trees, Forest, Rows, Cols) ->
  SortedTrees = lists:sort(fun({A, _, _}, {B, _, _}) -> A < B end, Trees),
  {_, StartRow, StartCol} = lists:nth(1, [{lists:nth(1, lists:nth(1, SortedTrees)), lists:nth(2, lists:nth(1, SortedTrees)), lists:nth(3, lists:nth(1, SortedTrees))}]),
  sorted_trees(SortedTrees, Forest, Rows, Cols, StartRow, StartCol, 0).

sorted_trees([], _Forest, _Rows, _Cols, _Row, _Col, Acc) ->
  Acc;
sorted_trees([{_, Row, Col}|Rest], Forest, Rows, Cols, StartRow, StartCol, Acc) ->
  Dist = shortest_path(Forest, Rows, Cols, StartRow, StartCol, Row, Col),
  case Dist of
    -1 ->
      -1;
    _ ->
      NewForest = update_forest(Forest, Row, Col),
      sorted_trees(Rest, NewForest, Rows, Cols, Row, Col, Acc + Dist)
  end.

update_forest(Forest, Row, Col) ->
  lists:map(fun(L, I) ->
                case I == Row+1 of
                  true ->
                    lists:map(fun(V, J) ->
                                  case J == Col+1 of
                                    true ->
                                      1;
                                    false ->
                                      V
                                  end
                               end, L, lists:seq(1, length(L)));
                  false ->
                    L
                end
            end, Forest, lists:seq(1, length(Forest))).

shortest_path(Forest, Rows, Cols, StartRow, StartCol, EndRow, EndCol) ->
  shortest_path(Forest, Rows, Cols, StartRow, StartCol, EndRow, EndCol, queue:new(), [{StartRow, StartCol}], 0, maps:new()).

shortest_path(_Forest, _Rows, _Cols, EndRow, EndCol, EndRow, EndCol, _Queue, _Visited, Acc, _VisitedMap) ->
  Acc;
shortest_path(Forest, Rows, Cols, Row, Col, EndRow, EndCol, Queue, Visited, Acc, VisitedMap) ->
  Neighbors = get_neighbors(Forest, Rows, Cols, Row, Col),
  NewNeighbors = lists:filter(fun({R, C}) -> not lists:member({R, C}, Visited) end, Neighbors),
  NewVisited = Visited ++ NewNeighbors,
  NewMap = lists:foldl(fun({R,C}, Map) -> maps:put({R,C}, 1, Map) end, VisitedMap, NewNeighbors),

  NewQueue = lists:foldl(fun({R, C}, Q) -> queue:in({R,C}, Q) end, Queue, NewNeighbors),
  case queue:is_empty(NewQueue) of
    true ->
      -1;
    false ->
      {Val, NewQueue2} = queue:out(NewQueue),
      case Val of
        {value, {NextRow, NextCol}} ->
          shortest_path(Forest, Rows, Cols, NextRow, NextCol, EndRow, EndCol, NewQueue2, NewVisited, Acc + 1, NewMap);
        empty ->
          -1
      end
  end.

get_neighbors(Forest, Rows, Cols, Row, Col) ->
  Neighbors = [{Row-1, Col}, {Row+1, Col}, {Row, Col-1}, {Row, Col+1}],
  lists:filter(fun({R, C}) ->
                  R >= 0 and R < Rows and C >= 0 and C < Cols and lists:nth(C+1, lists:nth(R+1, Forest)) > 0
               end, Neighbors).