-module(n_queens).
-export([solveNQueens/1]).

solveNQueens(N) ->
  solve(N, [], []).

solve(0, Board, Acc) ->
  [reverse(Board) | Acc];
solve(N, Board, Acc) ->
  N > 0 ->
    Len = length(Board);
    lists:foldl(
      fun(Col, Acc1) ->
        if
          is_safe(Col, Board, Len) ->
            solve(N - 1, [Col | Board], Acc1);
          true ->
            Acc1
        end
      end,
      Acc,
      lists:seq(1, length(Board) + 1)
    );
  true ->
    Acc.

is_safe(Col, Board, Row) ->
  is_safe_helper(Col, Board, Row, 0).

is_safe_helper(_, [], _, _)->
  true;
is_safe_helper(Col, [X | Rest], Row, I) ->
  if
    X == Col; true ->
      false;
    abs(X - Col) == Row - I; true ->
      false;
    true ->
      is_safe_helper(Col, Rest, Row, I + 1)
  end.