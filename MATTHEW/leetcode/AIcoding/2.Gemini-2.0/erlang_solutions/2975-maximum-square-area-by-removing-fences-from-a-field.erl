-module(max_square_area).
-export([max_square_area/3]).

max_square_area(M, N, HorizontalFences, VerticalFences) ->
  Horizontal = lists:sort([1, M] ++ HorizontalFences),
  Vertical = lists:sort([1, N] ++ VerticalFences),
  HDiffs = diffs(Horizontal),
  VDiffs = diffs(Vertical),
  CommonDiffs = lists:usort([ X || X <- HDiffs, lists:member(X, VDiffs)]),
  case CommonDiffs of
    [] -> -1;
    _ ->
      MaxVal = lists:max(CommonDiffs),
      (MaxVal * MaxVal) rem (1000000000 + 7)
  end.

diffs(List) ->
  diffs_helper(List, []).

diffs_helper([H1, H2 | T], Acc) ->
  diffs_helper([H2 | T], [H2 - H1 | Acc]);
diffs_helper([_], Acc) ->
  lists:reverse(Acc);
diffs_helper([], Acc) ->
  lists:reverse(Acc).