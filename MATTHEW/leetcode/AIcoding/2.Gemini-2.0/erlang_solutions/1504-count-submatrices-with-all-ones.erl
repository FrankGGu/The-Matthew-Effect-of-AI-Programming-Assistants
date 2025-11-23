-module(count_submatrices_with_all_ones).
-export([numSubmat/1]).

numSubmat(Mat) ->
  {Rows, Cols} = matrix_size(Mat),
  H = lists:foldl(fun(Row, Acc) -> [height(Row, Acc) | Acc] end, [], Mat),
  lists:foldl(fun(RowIdx, Acc) -> Acc + count_rectangles(lists:nth(RowIdx + 1, H)) end, 0, lists:seq(0, Rows - 1)).

matrix_size(Mat) ->
  Rows = length(Mat),
  Cols = length(lists:nth(1, Mat)),
  {Rows, Cols}.

height(Row, Acc) ->
  case Row of
    [] ->
      [];
    [1 | Rest] ->
      case Acc of
        [] -> 1;
        [H | _] -> H + 1
      end;
    [_ | Rest] ->
      0
  end.

count_rectangles(Heights) ->
  count_rectangles_helper(Heights, [], 0).

count_rectangles_helper([], _, Acc) ->
  Acc;
count_rectangles_helper([H | Rest], Stack, Acc) ->
  {NewStack, NewAcc} = process_height(H, Stack, Acc),
  count_rectangles_helper(Rest, NewStack, NewAcc).

process_height(H, Stack, Acc) ->
  {NewStack, NewAcc} = pop_smaller(H, Stack, Acc),
  NewStack2 = [{H, 1} | NewStack],
  {NewStack2, NewAcc}.

pop_smaller(H, Stack, Acc) ->
  case Stack of
    [] ->
      {[], Acc};
    [{StackH, StackW} | Rest] ->
      case StackH of
        H when H > StackH ->
          {[{StackH, StackW} | Rest], Acc};
        _ ->
          {NewStack, NewAcc} = pop_smaller(H, Rest, Acc + StackH * StackW),
          {NewStack, NewAcc}
      end
  end.