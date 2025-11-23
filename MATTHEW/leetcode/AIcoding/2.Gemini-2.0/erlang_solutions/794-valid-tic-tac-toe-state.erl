-module(valid_tic_tac_toe).
-export([valid_tic_tac_toe/1]).

valid_tic_tac_toe(Board) ->
  Xs = count_char(Board, $X),
  Os = count_char(Board, $O),

  case Xs - Os of
    0 ->
      not (win(Board, $X));
    1 ->
      not (win(Board, $O));
    _ ->
      false
  end and (Xs >= Os) and (Xs =< Os + 1).

count_char(Board, Char) ->
  lists:foldl(
    fun(Row, Acc) ->
      Acc + count_char_in_row(Row, Char)
    end,
    0,
    Board
  ).

count_char_in_row(Row, Char) ->
  lists:foldl(
    fun(C, Acc) ->
      case C of
        Char -> Acc + 1;
        _ -> Acc
      end
    end,
    0,
    Row
  ).

win(Board, Char) ->
  win_row(Board, Char) or
  win_col(Board, Char) or
  win_diag(Board, Char).

win_row(Board, Char) ->
  lists:any(
    fun(Row) ->
      lists:all(fun(C) -> C == Char end, Row)
    end,
    Board
  ).

win_col(Board, Char) ->
  [A, B, C] = Board,
  (A !! 0 == Char and B !! 0 == Char and C !! 0 == Char) or
  (A !! 1 == Char and B !! 1 == Char and C !! 1 == Char) or
  (A !! 2 == Char and B !! 2 == Char and C !! 2 == Char).

win_diag(Board, Char) ->
  [A, B, C] = Board,
  (A !! 0 == Char and B !! 1 == Char and C !! 2 == Char) or
  (A !! 2 == Char and B !! 1 == Char and C !! 0 == Char).