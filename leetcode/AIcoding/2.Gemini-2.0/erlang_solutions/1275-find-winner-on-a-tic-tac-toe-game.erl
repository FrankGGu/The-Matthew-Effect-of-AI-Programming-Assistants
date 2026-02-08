-module(tic_tac_toe).
-export([tictactoe/1]).

tictactoe(Moves) ->
  Board = lists:foldl(fun({X, Y}, Acc) ->
                            lists:nth(X + 1, Acc) ! put(Y, 1),
                            Acc
                        end,
                        [dict:new(), dict:new(), dict:new()],
                        lists:nth(1, lists:zip(Moves, lists:seq(1, length(Moves))))),
  BoardO = lists:foldl(fun({X, Y}, Acc) ->
                             lists:nth(X + 1, Acc) ! put(Y, 1),
                             Acc
                         end,
                         [dict:new(), dict:new(), dict:new()],
                         lists:nth(1, lists:zip(Moves, lists:seq(1, length(Moves), 2)))),
  BoardX = lists:foldl(fun({X, Y}, Acc) ->
                             lists:nth(X + 1, Acc) ! put(Y, 1),
                             Acc
                         end,
                         [dict:new(), dict:new(), dict:new()],
                         lists:nth(1, lists:zip(Moves, lists:seq(2, length(Moves), 2)))),

  winner(BoardO, BoardX, Moves).

winner(BoardO, BoardX, Moves) ->
  case check_winner(BoardX) of
    true -> "A";
    false ->
      case check_winner(BoardO) of
        true -> "B";
        false ->
          if length(Moves) == 9 then
            "Draw"
          else
            "Pending"
          end
      end
  end.

check_winner(Board) ->
  (dict:size(lists:nth(1, Board)) == 3) orelse
    (dict:size(lists:nth(2, Board)) == 3) orelse
    (dict:size(lists:nth(3, Board)) == 3) orelse
    check_cols(Board) orelse
    check_diagonals(Board).

check_cols(Board) ->
  try
    dict:fetch(0, lists:nth(1, Board)),
    dict:fetch(0, lists:nth(2, Board)),
    dict:fetch(0, lists:nth(3, Board)),
    true
  catch
    _:_ ->
      try
        dict:fetch(1, lists:nth(1, Board)),
        dict:fetch(1, lists:nth(2, Board)),
        dict:fetch(1, lists:nth(3, Board)),
        true
      catch
        _:_ ->
          try
            dict:fetch(2, lists:nth(1, Board)),
            dict:fetch(2, lists:nth(2, Board)),
            dict:fetch(2, lists:nth(3, Board)),
            true
          catch
            _:_ ->
              false
          end
      end
  end.

check_diagonals(Board) ->
  try
    dict:fetch(0, lists:nth(1, Board)),
    dict:fetch(1, lists:nth(2, Board)),
    dict:fetch(2, lists:nth(3, Board)),
    true
  catch
    _:_ ->
      try
        dict:fetch(2, lists:nth(1, Board)),
        dict:fetch(1, lists:nth(2, Board)),
        dict:fetch(0, lists:nth(3, Board)),
        true
      catch
        _:_ ->
          false
      end
  end.