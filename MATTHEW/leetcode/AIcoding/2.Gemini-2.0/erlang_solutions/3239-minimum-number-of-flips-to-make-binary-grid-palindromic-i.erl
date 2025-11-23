-module(minimum_flips_i).
-export([minFlips/1]).

minFlips(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  solve(Grid, Rows, Cols).

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  {Rows, Cols}.

solve(Grid, Rows, Cols) ->
  N = Rows * Cols,
  Result = lists:foldl(
    fun(Mask, Acc) ->
      MinFlips = calculate_flips(Grid, Rows, Cols, Mask),
      min(Acc, MinFlips)
    end,
    N + 1,
    lists:seq(0, (1 bsl N) - 1)
  ),
  if Result > N then -1 else Result end.

calculate_flips(Grid, Rows, Cols, Mask) ->
  FlippedGrid = flip_grid(Grid, Rows, Cols, Mask),
  if is_palindromic(FlippedGrid, Rows, Cols) then
    count_flips(Mask)
  else
    infinity
  end.

flip_grid(Grid, Rows, Cols, Mask) ->
  lists:map(
    fun(RowIndex) ->
      lists:map(
        fun(ColIndex) ->
          Index = (RowIndex - 1) * Cols + ColIndex - 1,
          if (Mask band (1 bsl Index)) > 0 then
            1 - lists:nth(ColIndex, lists:nth(RowIndex, Grid))
          else
            lists:nth(ColIndex, lists:nth(RowIndex, Grid))
          end
        end,
        lists:seq(1, Cols)
      )
    end,
    lists:seq(1, Rows)
  ).

is_palindromic(Grid, Rows, Cols) ->
  is_row_palindromic(Grid, Rows, Cols) and is_col_palindromic(Grid, Rows, Cols).

is_row_palindromic(Grid, Rows, Cols) ->
  lists:all(
    fun(RowIndex) ->
      Row = lists:nth(RowIndex, Grid),
      is_list_palindromic(Row)
    end,
    lists:seq(1, Rows)
  ).

is_col_palindromic(Grid, Rows, Cols) ->
  lists:all(
    fun(ColIndex) ->
      Col = [lists:nth(ColIndex, lists:nth(RowIndex, Grid)) || RowIndex <- lists:seq(1, Rows)],
      is_list_palindromic(Col)
    end,
    lists:seq(1, Cols)
  ).

is_list_palindromic(List) ->
  List =:= lists:reverse(List).

count_flips(Mask) ->
  count_bits(Mask, 0).

count_bits(0, Count) ->
  Count;
count_bits(N, Count) ->
  if (N band 1) =:= 1 then
    count_bits(N bsr 1, Count + 1)
  else
    count_bits(N bsr 1, Count)
  end.

infinity ->
  16777216.