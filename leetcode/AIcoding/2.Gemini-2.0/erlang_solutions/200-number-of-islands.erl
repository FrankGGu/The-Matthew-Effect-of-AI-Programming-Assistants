-module(number_of_islands).
-export([num_islands/1]).

num_islands(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  Visited = orddict:new(),
  num_islands_helper(Grid, Rows, Cols, 0, Visited).

num_islands_helper(_Grid, _Rows, _Cols, Count, _Visited) when _Rows < 1 ->
  Count;
num_islands_helper(Grid, Rows, Cols, Count, Visited) ->
  num_islands_helper_row(Grid, Rows, Cols, 1, Count, Visited).

num_islands_helper_row(_Grid, Rows, _Cols, _Col, Count, _Visited) when _Col > length(hd(_Grid)) ->
  num_islands_helper(_Grid, Rows - 1, _Cols, Count, _Visited);
num_islands_helper_row(Grid, Rows, Cols, Col, Count, Visited) ->
  Value = lists:nth(Col, lists:nth(Rows, Grid)),
  case orddict:is_key({Rows, Col}, Visited) of
    true ->
      num_islands_helper_row(Grid, Rows, Cols, Col + 1, Count, Visited);
    false ->
      case Value of
        "1" ->
          {NewCount, NewVisited} = dfs(Grid, Rows, Cols, Col, Count + 1, Visited),
          num_islands_helper_row(Grid, Rows, Cols, Col + 1, NewCount, NewVisited);
        "0" ->
          num_islands_helper_row(Grid, Rows, Cols, Col + 1, Count, Visited)
      end
  end.

dfs(Grid, Rows, Cols, Col, Count, Visited) ->
  dfs_helper(Grid, Rows, Cols, Col, Count, Visited, []).

dfs_helper(Grid, Rows, Cols, Col, Count, Visited, Queue) ->
  case Queue of
    [] ->
      dfs_start(Grid, Rows, Cols, Col, Count, Visited);
    [{Row, C} | Rest] ->
      case orddict:is_key({Row, C}, Visited) of
        true ->
          dfs_helper(Grid, Rows, Cols, Col, Count, Visited, Rest);
        false ->
          Value = lists:nth(C, lists:nth(Row, Grid)),
          case Value of
            "1" ->
              NewVisited = orddict:store({Row, C}, true, Visited),
              NewQueue = Rest ++ get_neighbors(Row, C, Rows, Cols),
              dfs_helper(Grid, Rows, Cols, Col, Count, NewVisited, NewQueue);
            "0" ->
              NewVisited = orddict:store({Row, C}, true, Visited),
              dfs_helper(Grid, Rows, Cols, Col, Count, NewVisited, Rest)
          end
      end
  end.

dfs_start(Grid, Rows, Cols, Col, Count, Visited) ->
  case orddict:is_key({Rows, Col}, Visited) of
    true ->
      {Count, Visited};
    false ->
      Value = lists:nth(Col, lists:nth(Rows, Grid)),
      case Value of
        "1" ->
          NewVisited = orddict:store({Rows, Col}, true, Visited),
          NewQueue = get_neighbors(Rows, Col, Rows, Cols),
          dfs_helper(Grid, Rows, Cols, Col, Count, NewVisited, NewQueue);
        "0" ->
          NewVisited = orddict:store({Rows, Col}, true, Visited),
          {Count, NewVisited}
      end
  end.

get_neighbors(Row, Col, Rows, Cols) ->
  Neighbors = [],
  NewNeighbors =
    case Row > 1 of
      true ->
        [{Row - 1, Col} | Neighbors];
      false ->
        Neighbors
    end,
  NewNeighbors1 =
    case Row < Rows of
      true ->
        [{Row + 1, Col} | NewNeighbors];
      false ->
        NewNeighbors
    end,
  NewNeighbors2 =
    case Col > 1 of
      true ->
        [{Row, Col - 1} | NewNeighbors1];
      false ->
        NewNeighbors1
    end,
  case Col < Cols of
    true ->
      [{Row, Col + 1} | NewNeighbors2];
    false ->
      NewNeighbors2
  end.