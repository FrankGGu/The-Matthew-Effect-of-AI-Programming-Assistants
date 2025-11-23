-module(minimum_falling_path_sum).
-export([minFallingPathSum/1]).

minFallingPathSum(Matrix) ->
  N = length(Matrix),
  memo(Matrix, N).

memo(Matrix, N) ->
  memo(Matrix, N, []).

memo(Matrix, N, Memo) ->
  case N of
    0 ->
      lists:min([hd(Row) || Row <- Matrix]);
    _ ->
      NewMatrix = [ [get_min(Matrix, RowIndex, ColIndex) || ColIndex <- lists:seq(1,N)] || RowIndex <- lists:seq(2,N)],
      memo(NewMatrix, N - 1, Memo)
  end.

get_min(Matrix, RowIndex, ColIndex) ->
  Val = lists:nth(RowIndex, Matrix),
  CurVal = lists:nth(ColIndex, Val),
  PrevRow = lists:nth(RowIndex - 1, Matrix),
  PrevColMin =
    case ColIndex of
      1 ->
        lists:min([lists:nth(ColIndex, PrevRow), lists:nth(ColIndex + 1, PrevRow)]);
      N ->
        lists:min([lists:nth(ColIndex, PrevRow), lists:nth(ColIndex - 1, PrevRow)]);
      _ ->
        lists:min([lists:nth(ColIndex, PrevRow), lists:nth(ColIndex - 1, PrevRow), lists:nth(ColIndex + 1, PrevRow)])
    end,
  CurVal + PrevColMin.