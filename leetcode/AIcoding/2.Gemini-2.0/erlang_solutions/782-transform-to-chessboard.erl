-module(transform_chessboard).
-export([transform_chessboard/1]).

transform_chessboard(Board) ->
  N = length(Board),
  ColSum = lists:sum([lists:nth(1, Row) of Row <- Board]),
  RowSum = lists:sum([lists:nth(X, lists:nth(1, Board)) of X <- lists:seq(1, N)]),
  RowSwap = count_swaps(Board),
  ColSwap = count_swaps(transpose(Board)),

  if (ColSum /= N div 2) and (ColSum /= (N + 1) div 2) orelse
     (RowSum /= N div 2) and (RowSum /= (N + 1) div 2)  orelse
     (N rem 2 == 0 and (ColSum /= N div 2 orelse RowSum /= N div 2))
  then
    -1
  else
    RowSwapRes = case N rem 2 of
                    0 ->
                      min(RowSwap, N div 2 - RowSwap);
                    1 ->
                      RowSwap
                  end,
    ColSwapRes = case N rem 2 of
                    0 ->
                      min(ColSwap, N div 2 - ColSwap);
                    1 ->
                      ColSwap
                  end,
    RowSwapRes + ColSwapRes
  end.

count_swaps(Board) ->
  N = length(Board),
  Ones = lists:foldl(fun(Row, Acc) ->
                        case lists:nth(1, Row) of
                          1 -> Acc + 1;
                          _ -> Acc
                        end
                      end, 0, Board),

  if Ones <= N div 2 then
    Swaps = lists:foldl(fun({Row, Index}, Acc) ->
                         if lists:nth(1, Row) /= Index rem 2 then
                           Acc + 1
                         else
                           Acc
                         end
                       end, 0, lists:zip(Board, lists:seq(0, N - 1))),
    Swaps div 2
  else
    Swaps = lists:foldl(fun({Row, Index}, Acc) ->
                         if lists:nth(1, Row) /= (Index + 1) rem 2 then
                           Acc + 1
                         else
                           Acc
                         end
                       end, 0, lists:zip(Board, lists:seq(0, N - 1))),
    Swaps div 2
  end.

transpose(Board) ->
  N = length(Board),
  lists:map(fun(X) ->
              lists:map(fun(Row) ->
                          lists:nth(X, Row)
                        end, Board)
            end, lists:seq(1, N)).