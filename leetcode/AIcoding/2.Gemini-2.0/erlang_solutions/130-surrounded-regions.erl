-module(surrounded_regions).
-export([solve/1]).

solve(Board) ->
  {Rows, Cols} = board_size(Board),
  NewBoard = mark_boundary(Board, Rows, Cols),
  flip_os(NewBoard).

board_size(Board) ->
  Rows = length(Board),
  case Rows > 0 of
    true -> Cols = length(hd(Board));
    false -> Cols = 0
  end,
  {Rows, Cols}.

mark_boundary(Board, Rows, Cols) ->
  mark_boundary_helper(Board, Rows, Cols, 0, 0).

mark_boundary_helper(Board, Rows, Cols, I, 0) when I >= Rows ->
  mark_boundary_helper(Board, Rows, Cols, 0, 1);
mark_boundary_helper(Board, Rows, Cols, I, Cols) when I < Rows ->
  mark_boundary_helper(Board, Rows, Cols, I + 1, 0);
mark_boundary_helper(Board, Rows, Cols, Rows, Cols) ->
  Board;
mark_boundary_helper(Board, Rows, Cols, I, J) ->
  case element(J + 1, lists:nth(I + 1, Board)) of
    'O' ->
      NewBoard = set_element(Board, I, J, 'M'),
      NewBoard2 = mark_boundary_helper(dfs(NewBoard, Rows, Cols, I, J), Rows, Cols, I + 1, J + 1);
    _ ->
      mark_boundary_helper(Board, Rows, Cols, I, J + 1)
  end.

dfs(Board, Rows, Cols, I, J) ->
  dfs_helper(Board, Rows, Cols, I, J, []).

dfs_helper(Board, Rows, Cols, I, J, Visited) ->
  case lists:member({I, J}, Visited) of
    true ->
      Board;
    false ->
      case is_valid(I, J, Rows, Cols) of
        false ->
          Board;
        true ->
          case element(J + 1, lists:nth(I + 1, Board)) of
            'O' ->
              NewBoard = set_element(Board, I, J, 'M'),
              NewBoard1 = dfs_helper(NewBoard, Rows, Cols, I - 1, J, [{I, J} | Visited]),
              NewBoard2 = dfs_helper(NewBoard1, Rows, Cols, I + 1, J, [{I, J} | Visited]),
              NewBoard3 = dfs_helper(NewBoard2, Rows, Cols, I, J - 1, [{I, J} | Visited]),
              NewBoard4 = dfs_helper(NewBoard3, Rows, Cols, I, J + 1, [{I, J} | Visited]);
            _ ->
              Board
          end
      end
  end.

is_valid(I, J, Rows, Cols) ->
  I >= 0 and I < Rows and J >= 0 and J < Cols.

set_element(Board, I, J, Value) ->
  Row = lists:nth(I + 1, Board),
  NewRow = setelement(J + 1, Row, Value),
  lists:nth(I + 1, Board) := NewRow,
  Board.

flip_os(Board) ->
  flip_os_helper(Board, 0).

flip_os_helper(Board, I) when I >= length(Board) ->
  Board;
flip_os_helper(Board, I) ->
  Row = lists:nth(I + 1, Board),
  NewRow = flip_row(Row),
  lists:nth(I + 1, Board) := NewRow,
  flip_os_helper(Board, I + 1).

flip_row(Row) ->
  flip_row_helper(Row, 1, []).

flip_row_helper(Row, I, Acc) when I > length(Row) ->
  lists:reverse(Acc);
flip_row_helper(Row, I, Acc) ->
  case element(I, Row) of
    'M' ->
      flip_row_helper(Row, I + 1, ['O' | Acc]);
    'O' ->
      flip_row_helper(Row, I + 1, ['X' | Acc]);
    'X' ->
      flip_row_helper(Row, I + 1, ['X' | Acc])
  end.