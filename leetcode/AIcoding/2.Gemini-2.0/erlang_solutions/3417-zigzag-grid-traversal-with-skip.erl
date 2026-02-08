-module(zigzag_grid_traversal_with_skip).
-export([zigzag_traverse_with_skip/3]).

zigzag_traverse_with_skip(Grid, M, N) ->
  zigzag_traverse_with_skip(Grid, M, N, 0, 0, true, []).

zigzag_traverse_with_skip(_Grid, _M, _N, Row, Col, _Up, Acc) when Row < 0 orelse Col < 0 ->
  lists:reverse(Acc);
zigzag_traverse_with_skip(_Grid, _M, _N, Row, Col, _Up, Acc) when Row >= _M orelse Col >= _N ->
  lists:reverse(Acc);
zigzag_traverse_with_skip(Grid, M, N, Row, Col, Up, Acc) ->
  NewAcc = [lists:nth(Col + 1, lists:nth(Row + 1, Grid)) | Acc],
  case Up of
    true ->
      NewRow = Row - 1,
      NewCol = Col + 1,
      case {NewRow < 0, NewCol >= N} of
        {true, true} ->
          zigzag_traverse_with_skip(Grid, M, N, Row + 1, Col, false, NewAcc);
        {true, false} ->
          zigzag_traverse_with_skip(Grid, M, N, Row, Col + 1, false, NewAcc);
        {false, true} ->
          zigzag_traverse_with_skip(Grid, M, N, Row + 1, Col, false, NewAcc);
        {false, false} ->
          zigzag_traverse_with_skip(Grid, M, N, NewRow, NewCol, false, NewAcc)
      end;
    false ->
      NewRow = Row + 1,
      NewCol = Col - 1,
      case {NewRow >= M, NewCol < 0} of
        {true, true} ->
          zigzag_traverse_with_skip(Grid, M, N, Row, Col + 1, true, NewAcc);
        {true, false} ->
          zigzag_traverse_with_skip(Grid, M, N, Row, Col + 1, true, NewAcc);
        {false, true} ->
          zigzag_traverse_with_skip(Grid, M, N, Row + 1, Col, true, NewAcc);
        {false, false} ->
          zigzag_traverse_with_skip(Grid, M, N, NewRow, NewCol, true, NewAcc)
      end
  end.