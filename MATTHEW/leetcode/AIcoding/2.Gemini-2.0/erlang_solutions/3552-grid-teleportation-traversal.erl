-module(grid_teleportation_traversal).
-export([solve/1]).

solve(Grid) ->
  solve(Grid, {0, 0}, [], []).

solve(Grid, {Row, Col}, Visited, Path) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),

  case {Row, Col} of
    {Rows - 1, Cols - 1} ->
      lists:reverse([{Row, Col} | Path]);
    _ ->
      case lists:member({Row, Col}, Visited) of
        true ->
          [];
        false ->
          Next = get_next_moves(Grid, {Row, Col}, Rows, Cols),
          solve_next(Grid, Next, [{Row, Col} | Visited], [{Row, Col} | Path], Rows, Cols)
      end
  end.

solve_next(_Grid, [], _Visited, _Path, _Rows, _Cols) ->
  [];
solve_next(Grid, [Move | Rest], Visited, Path, Rows, Cols) ->
  Result = solve(Grid, Move, Visited, Path),
  case Result of
    [] ->
      solve_next(Grid, Rest, Visited, Path, Rows, Cols);
    _ ->
      Result
  end.

get_next_moves(Grid, {Row, Col}, Rows, Cols) ->
  Value = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
  {NewRow, NewCol} = {Value div Cols, Value rem Cols},
  PossibleMoves = [{Row + 1, Col}, {Row - 1, Col}, {Row, Col + 1}, {Row, Col - 1}, {NewRow, NewCol}],
  lists:filter(fun({R, C}) -> R >= 0 and R < Rows and C >= 0 and C < Cols end, PossibleMoves).