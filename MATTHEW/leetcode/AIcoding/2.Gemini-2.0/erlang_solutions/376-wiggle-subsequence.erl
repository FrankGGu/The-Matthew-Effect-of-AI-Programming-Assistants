-module(wiggle_subsequence).
-export([wiggleMaxLength/1]).

wiggleMaxLength(Nums) ->
  wiggleMaxLength(Nums, 0, 0, 0).

wiggleMaxLength([], _, _, Count) ->
  Count;
wiggleMaxLength([H | T], Prev, Diff, Count) ->
  case {Count == 0, Diff == 0, H > Prev, H < Prev} of
    {true, _, _, _} ->
      wiggleMaxLength(T, H, 0, 1);
    {false, true, true, _} ->
      wiggleMaxLength(T, H, 1, Count + 1);
    {false, true, false, _} ->
      wiggleMaxLength(T, H, -1, Count + 1);
    {false, false, true, _} when Diff < 0 ->
      wiggleMaxLength(T, H, 1, Count + 1);
    {false, false, false, true} when Diff > 0 ->
      wiggleMaxLength(T, H, -1, Count + 1);
    _ ->
      wiggleMaxLength(T, H, Diff, Count)
  end.