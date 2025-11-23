-module(large_island).
-export([largest_island/1]).

largest_island(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  {NewGrid, Islands} = find_islands(Grid, Rows, Cols),
  max_island_size(NewGrid, Islands, Rows, Cols).

grid_size(Grid) ->
  {length(Grid), length(hd(Grid))}.

find_islands(Grid, Rows, Cols) ->
  find_islands(Grid, Rows, Cols, 1, 1, []).

find_islands(Grid, Rows, Cols, Row, Col, Islands) ->
  case Row > Rows of
    true ->
      {Grid, Islands};
    false ->
      case Col > Cols of
        true ->
          find_islands(Grid, Rows, Cols, Row + 1, 1, Islands);
        false ->
          case element(Col, element(Row, Grid)) of
            1 ->
              {NewGrid, NewIslands} = explore_island(Grid, Rows, Cols, Row, Col, length(Islands) + 2),
              find_islands(NewGrid, Rows, Cols, Row, Col + 1, [size(NewGrid, length(Islands) + 2, Rows, Cols) | NewIslands]);
            _ ->
              find_islands(Grid, Rows, Cols, Row, Col + 1, Islands)
          end
      end
  end.

explore_island(Grid, Rows, Cols, Row, Col, IslandId) ->
  explore_island(Grid, Rows, Cols, Row, Col, IslandId, []).

explore_island(Grid, Rows, Cols, Row, Col, IslandId, Visited) ->
  case is_visited({Row, Col}, Visited) of
    true ->
      {Grid, Visited};
    false ->
      case Row < 1 or Row > Rows or Col < 1 or Col > Cols or element(Col, element(Row, Grid)) /= 1 of
        true ->
          {Grid, [{Row, Col} | Visited]};
        false ->
          NewGrid = set_element(Row, Col, IslandId, Grid),
          {NewGrid1, Visited1} = explore_island(NewGrid, Rows, Cols, Row + 1, Col, IslandId, [{Row, Col} | Visited]),
          {NewGrid2, Visited2} = explore_island(NewGrid1, Rows, Cols, Row - 1, Col, IslandId, Visited1),
          {NewGrid3, Visited3} = explore_island(NewGrid2, Rows, Cols, Row, Col + 1, IslandId, Visited2),
          {NewGrid4, Visited4} = explore_island(NewGrid3, Rows, Cols, Row, Col - 1, IslandId, Visited3),
          {NewGrid4, Visited4}
      end
  end.

is_visited({Row, Col}, Visited) ->
  lists:member({Row, Col}, Visited).

set_element(Row, Col, Value, Grid) ->
  RowList = element(Row, Grid),
  NewRowList = lists:nthchange(Col, Value, RowList),
  lists:nthchange(Row, NewRowList, Grid).

size(Grid, IslandId, Rows, Cols) ->
  size(Grid, IslandId, Rows, Cols, 0).

size(Grid, IslandId, Rows, Cols, Acc) ->
  case Rows < 1 of
    true ->
      Acc;
    false ->
      case Cols < 1 of
        true ->
          size(Grid, IslandId, Rows - 1, length(hd(Grid)), Acc);
        false ->
          case element(Cols, element(Rows, Grid)) == IslandId of
            true ->
              size(Grid, IslandId, Rows, Cols - 1, Acc + 1);
            false ->
              size(Grid, IslandId, Rows, Cols - 1, Acc)
          end
      end
  end.

max_island_size(Grid, Islands, Rows, Cols) ->
  max_island_size(Grid, Islands, Rows, Cols, 0).

max_island_size(Grid, [], Rows, Cols, Max) ->
  Max;
max_island_size(Grid, [IslandSize | Rest], Rows, Cols, Max) ->
  max_island_size(Grid, Rest, Rows, Cols, max(Max, IslandSize + potential_connections(Grid, IslandSize, Rows, Cols))).

potential_connections(Grid, IslandSize, Rows, Cols) ->
  potential_connections(Grid, IslandSize, Rows, Cols, 0).

potential_connections(Grid, IslandSize, Rows, Cols, Max) ->
  case Rows < 1 of
    true ->
      Max;
    false ->
      case Cols < 1 of
        true ->
          potential_connections(Grid, IslandSize, Rows - 1, length(hd(Grid)), Max);
        false ->
          case element(Cols, element(Rows, Grid)) == 0 of
            true ->
                NewMax = Max + (
                                (Rows > 1 and element(Cols, element(Rows -1, Grid)) =/= 0 and element(Cols, element(Rows -1, Grid)) =/= 1) +
                                (Rows < length(Grid) and element(Cols, element(Rows + 1, Grid)) =/= 0 and element(Cols, element(Rows + 1, Grid)) =/= 1) +
                                (Cols > 1 and element(Cols - 1, element(Rows, Grid)) =/= 0 and element(Cols - 1, element(Rows, Grid)) =/= 1) +
                                (Cols < length(hd(Grid)) and element(Cols + 1, element(Rows, Grid)) =/= 0 and element(Cols + 1, element(Rows, Grid)) =/= 1)
                                > 0),
              potential_connections(Grid, IslandSize, Rows, Cols - 1, NewMax);
            false ->
              potential_connections(Grid, IslandSize, Rows, Cols - 1, Max)
          end
      end
  end.