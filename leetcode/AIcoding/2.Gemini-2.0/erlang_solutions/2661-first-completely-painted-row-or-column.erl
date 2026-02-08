-module(first_complete_paint).
-export([first_complete_paint/2]).

first_complete_paint(Arr, [M, N]) ->
  first_complete_paint(Arr, [M, N], 0, lists:seq(1, M), lists:seq(1, N), []).

first_complete_paint([], _, _, _, _, Acc) ->
  case Acc of
    [] -> -1;
    [H|_] -> H
  end;

first_complete_paint([H|T], [M, N], Idx, Rows, Cols, Acc) ->
  [R, C] = H,
  NewRows = lists:delete(R, Rows),
  NewCols = lists:delete(C, Cols),
  case {NewRows == [], NewCols == []} of
    {true, _} ->
      first_complete_paint(T, [M, N], Idx+1, NewRows, NewCols, [Idx+1|Acc]);
    {_, true} ->
      first_complete_paint(T, [M, N], Idx+1, NewRows, NewCols, [Idx+1|Acc]);
    {false, false} ->
      first_complete_paint(T, [M, N], Idx+1, NewRows, NewCols, Acc)
  end.