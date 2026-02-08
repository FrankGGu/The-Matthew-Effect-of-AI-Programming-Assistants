-module(maximum_moves_in_a_grid).
-export([max_moves/1]).

max_moves(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  max_moves_helper(Grid, Rows, Cols).

max_moves_helper(Grid, Rows, Cols) ->
  max_moves_helper(Grid, Rows, Cols, 0, 0, 0, []).

max_moves_helper(Grid, Rows, Cols, Row, Col, Moves, Visited) ->
  case (Row >= 0) and (Row < Rows) and (Col >= 0) and (Col < Cols) of
    true ->
      Neighbors = get_neighbors(Grid, Rows, Cols, Row, Col),
      case Neighbors of
        [] ->
          Moves;
        _ ->
          NextMoves = [max_moves_helper(Grid, Rows, Cols, NRow, NCol, Moves + 1, Visited ++ [{Row, Col}]) || {NRow, NCol} <- Neighbors],
          lists:max([Moves | NextMoves])
      end;
    false ->
      Moves
  end.

get_neighbors(Grid, Rows, Cols, Row, Col) ->
  Value = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
  Neighbors = [{Row - 1, Col + 1}, {Row, Col + 1}, {Row + 1, Col + 1}],
  filter_valid_neighbors(Grid, Rows, Cols, Value, Neighbors).

filter_valid_neighbors(Grid, Rows, Cols, Value, Neighbors) ->
  lists:filter(fun({Row, Col}) ->
                  (Row >= 0) and (Row < Rows) and (Col >= 0) and (Col < Cols) and
                    (lists:nth(Col + 1, lists:nth(Row + 1, Grid)) > Value)
              end, Neighbors).

max_moves_helper(Grid, Rows, Cols, Row, Col, MaxMoves, Visited) ->
    case (Row >= 0) and (Row < Rows) and (Col >= 0) and (Col < Cols) and (not lists:member({Row, Col}, Visited)) of
        true ->
            Value = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
            Neighbors = get_neighbors_2(Grid, Rows, Cols, Row, Col, Value),
            case Neighbors of
                [] ->
                    MaxMoves;
                _ ->
                    NewMaxMoves = [max_moves_helper(Grid, Rows, Cols, NRow, NCol, MaxMoves + 1, Visited ++ [{Row, Col}]) || {NRow, NCol} <- Neighbors],
                    lists:max([MaxMoves|NewMaxMoves])
            end;
        false ->
            MaxMoves
    end.

get_neighbors_2(Grid, Rows, Cols, Row, Col, Value) ->
    Neighbors = [{Row - 1, Col + 1}, {Row, Col + 1}, {Row + 1, Col + 1}],
    lists:filter(fun({NRow, NCol}) ->
                     (NRow >= 0) and (NRow < Rows) and (NCol >= 0) and (NCol < Cols) and
                         (lists:nth(NCol + 1, lists:nth(NRow + 1, Grid)) > Value)
                 end, Neighbors).

max_moves(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    lists:max([max_moves_entry(Grid, Rows, Cols, Row, 0, 0, []) || Row <- lists:seq(0, Rows - 1)]).

max_moves_entry(Grid, Rows, Cols, Row, Col, Moves, Visited) ->
    case (Row >= 0) and (Row < Rows) and (Col >= 0) and (Col < Cols) and (not lists:member({Row, Col}, Visited)) of
        true ->
            Value = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
            Neighbors = get_neighbors_3(Grid, Rows, Cols, Row, Col, Value),
            case Neighbors of
                [] ->
                    Moves;
                _ ->
                    NewMoves = [max_moves_entry(Grid, Rows, Cols, NRow, NCol, Moves + 1, Visited ++ [{Row, Col}]) || {NRow, NCol} <- Neighbors],
                    lists:max(NewMoves)
            end;
        false ->
            Moves
    end.

get_neighbors_3(Grid, Rows, Cols, Row, Col, Value) ->
    Neighbors = [{Row - 1, Col + 1}, {Row, Col + 1}, {Row + 1, Col + 1}],
    lists:filter(fun({NRow, NCol}) ->
                     (NRow >= 0) and (NRow < Rows) and (NCol >= 0) and (NCol < Cols) and
                         (lists:nth(NCol + 1, lists:nth(NRow + 1, Grid)) > Value)
                 end, Neighbors).