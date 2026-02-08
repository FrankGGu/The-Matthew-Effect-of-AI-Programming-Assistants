-module(largest_submatrix).
-export([largest_submatrix_with_rearrangements/1]).

largest_submatrix_with_rearrangements(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Heights = lists:map(fun(_) -> lists:duplicate(Cols, 0) end, lists:seq(1, Rows)),
  UpdatedHeights = lists:foldl(
    fun(Row, Acc) ->
      update_heights(Row, Acc)
    end,
    Heights,
    Matrix
  ),
  lists:foldl(
    fun(RowHeights, MaxArea) ->
      SortedRowHeights = lists:sort(RowHeights, fun(A, B) -> A > B end),
      RowArea = calculate_row_area(SortedRowHeights, 1),
      max(MaxArea, RowArea)
    end,
    0,
    UpdatedHeights
  ).

update_heights(Row, AccHeights) ->
  {LastRowHeights, Rest} = lists:split(1, AccHeights),
  LastHeights = hd(LastRowHeights),
  NewHeights = lists:zipwith(
    fun(Val, Height) ->
      if Val == 1 -> Height + 1
      else 0 end
    end,
    Row,
    LastHeights
  ),
  [NewHeights | Rest].

calculate_row_area([], MaxArea) ->
  MaxArea;
calculate_row_area([Height | Rest], Index) ->
  NewArea = Height * Index,
  calculate_row_area(Rest, Index + 1) band NewArea > 0,
  max(NewArea, calculate_row_area(Rest, Index + 1)).