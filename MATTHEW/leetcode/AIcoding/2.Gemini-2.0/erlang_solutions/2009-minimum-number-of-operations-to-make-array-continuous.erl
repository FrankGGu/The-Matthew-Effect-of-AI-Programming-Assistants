-module(minimum_operations_to_make_array_continuous).
-export([find_min_operations/1]).

find_min_operations(Nums) ->
  SortedNums = lists:sort(lists:usort(Nums)),
  N = length(Nums),
  Len = length(SortedNums),
  find_min_operations_helper(SortedNums, 0, N, Len, 0).

find_min_operations_helper(SortedNums, Left, N, Len, MinOps) ->
  case Left >= Len of
    true ->
      MinOps;
    false ->
      Right = find_right(SortedNums, Left, N, Len, SortedNums[Left + 1] + N - 1),
      Ops = N - (Right - Left + 1),
      find_min_operations_helper(SortedNums, Left + 1, N, Len, min(MinOps, Ops))
  end.

find_right(SortedNums, Left, N, Len, Target) ->
  find_right_helper(SortedNums, Left, Len - 1, Target).

find_right_helper(SortedNums, Left, Right, Target) ->
  case Left > Right of
    true ->
      Left - 1;
    false ->
      Mid = (Left + Right) div 2,
      case SortedNums[Mid + 1] =< Target of
        true ->
          find_right_helper(SortedNums, Mid + 1, Right, Target);
        false ->
          find_right_helper(SortedNums, Left, Mid - 1, Target)
      end
  end.