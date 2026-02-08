-module(escape_the_spreading_fire).
-export([maximum_minutes/1]).

maximum_minutes(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  {FireStarts, Start} = find_start_and_fire(Grid, Rows, Cols),
  binary_search(0, Rows * Cols, Grid, Rows, Cols, FireStarts, Start).

find_start_and_fire(Grid, Rows, Cols) ->
  find_start_and_fire_helper(Grid, Rows, Cols, 0, 0, [], []).

find_start_and_fire_helper(_Grid, Rows, _Cols, Rows, _, FireStarts, Start) ->
  {FireStarts, Start};
find_start_and_fire_helper(Grid, Rows, Cols, Row, Col, FireStarts, Start) ->
  case lists:nth(Row + 1, lists:nth(Col + 1, Grid)) of
    'S' ->
      find_start_and_fire_helper(Grid, Rows, Cols, next_row(Row, Col, Cols), [Row * Cols + Col], Start);
    'F' ->
      find_start_and_fire_helper(Grid, Rows, Cols, next_row(Row, Col, Cols), [Row * Cols + Col | FireStarts], Start);
    _ ->
      find_start_and_fire_helper(Grid, Rows, Cols, next_row(Row, Col, Cols), FireStarts, Start)
  end.

next_row(Row, Col, Cols) ->
  if Col + 1 < Cols then
    {Row, Col + 1}
  else
    {Row + 1, 0}
  end.

binary_search(Low, High, Grid, Rows, Cols, FireStarts, Start) ->
  case Low > High of
    true ->
      Low - 1;
    false ->
      Mid = (Low + High) div 2,
      case is_possible(Grid, Rows, Cols, FireStarts, Start, Mid) of
        true ->
          binary_search(Mid + 1, High, Grid, Rows, Cols, FireStarts, Start);
        false ->
          binary_search(Low, Mid - 1, Grid, Rows, Cols, FireStarts, Start)
      end
  end.

is_possible(Grid, Rows, Cols, FireStarts, Start, WaitTime) ->
  FireGrid = spread_fire(Grid, Rows, Cols, FireStarts, 0),
  PlayerGrid = bfs(Grid, Rows, Cols, [Start], WaitTime, FireGrid),
  case PlayerGrid of
    error ->
      false;
    _ ->
      true
  end.

bfs(Grid, Rows, Cols, Queue, WaitTime, FireGrid) ->
  bfs_helper(Grid, Rows, Cols, Queue, WaitTime, FireGrid, []).

bfs_helper(_Grid, Rows, Cols, [], _WaitTime, _FireGrid, Visited) ->
  case lists:member( (Rows - 1) * Cols + (Cols - 1), Visited) of
    true ->
      Visited;
    false ->
      error
  end;
bfs_helper(Grid, Rows, Cols, [Pos | Rest], WaitTime, FireGrid, Visited) ->
  case lists:member(Pos, Visited) of
    true ->
      bfs_helper(Grid, Rows, Cols, Rest, WaitTime, FireGrid, Visited);
    false ->
      Row = Pos div Cols,
      Col = Pos rem Cols,
      Time = WaitTime + length(Visited) + 1,
      FireTime = maps:get(Pos, FireGrid, infinity),
      case (Row == Rows - 1) and (Col == Cols - 1) of
        true ->
          case Time =< FireTime of
            true ->
              Visited ++ [Pos];
            false ->
              error
          end;
        false ->
          case Time < FireTime of
            true ->
              Neighbors = get_neighbors(Grid, Rows, Cols, Row, Col),
              ValidNeighbors = [N || N <- Neighbors, not lists:member(N, Visited)],
              bfs_helper(Grid, Rows, Cols, Rest ++ ValidNeighbors, WaitTime, FireGrid, Visited ++ [Pos]);
            false ->
              error
          end
      end
  end.

get_neighbors(Grid, Rows, Cols, Row, Col) ->
  Neighbors = [],
  Neighbors1 = case Row > 0 of
    true ->
      case lists:nth(Row, lists:nth(Col + 1, Grid)) of
        'W' ->
          Neighbors;
        _ ->
          [Neighbors ++ [ (Row - 1) * Cols + Col]]
      end;
    false ->
      Neighbors
  end,
  Neighbors2 = case Row + 1 < Rows of
    true ->
      case lists:nth(Row + 2, lists:nth(Col + 1, Grid)) of
        'W' ->
          Neighbors1;
        _ ->
          [Neighbors1 ++ [ (Row + 1) * Cols + Col]]
      end;
    false ->
      Neighbors1
  end,
  Neighbors3 = case Col > 0 of
    true ->
      case lists:nth(Row + 1, lists:nth(Col, Grid)) of
        'W' ->
          Neighbors2;
        _ ->
          [Neighbors2 ++ [ Row * Cols + (Col - 1)]]
      end;
    false ->
      Neighbors2
  end,
  Neighbors4 = case Col + 1 < Cols of
    true ->
      case lists:nth(Row + 1, lists:nth(Col + 2, Grid)) of
        'W' ->
          Neighbors3;
        _ ->
          [Neighbors3 ++ [ Row * Cols + (Col + 1)]]
      end;
    false ->
      Neighbors3
  end,
  lists:flatten(Neighbors4).

spread_fire(Grid, Rows, Cols, FireStarts, Time) ->
  InitialMap = maps:from_list([{P, 0} || P <- FireStarts]),
  spread_fire_helper(Grid, Rows, Cols, FireStarts, Time, InitialMap).

spread_fire_helper(Grid, Rows, Cols, [], _Time, Acc) ->
  Acc;
spread_fire_helper(Grid, Rows, Cols, FireSources, Time, Acc) ->
  NewFireSources = [],
  NewAcc = lists:foldl(
    fun(Pos, CurrentAcc) ->
      Row = Pos div Cols,
      Col = Pos rem Cols,
      Neighbors = get_neighbors(Grid, Rows, Cols, Row, Col),
      lists:foldl(
        fun(Neighbor, NewFire) ->
          case maps:is_key(Neighbor, NewFire) of
            true ->
              NewFire;
            false ->
              case maps:get(Neighbor, Acc, infinity) of
                infinity ->
                  NewFireSources1 = [Neighbor | NewFireSources],
                  NewFireSources = NewFireSources1,
                  maps:put(Neighbor, Time + 1, NewFire);
                _ ->
                  NewFire
              end
          end
        end,
        CurrentAcc,
        Neighbors
      )
    end,
    Acc,
    FireSources
  ),
  case NewFireSources of
    [] ->
      NewAcc;
    _ ->
      spread_fire_helper(Grid, Rows, Cols, NewFireSources, Time + 1, NewAcc)
  end.