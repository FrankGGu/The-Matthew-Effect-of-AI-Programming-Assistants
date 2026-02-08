-module(three_sum).
-export([three_sum/1]).

three_sum(Nums) ->
  case length(Nums) < 3 of
    true -> [];
    false ->
      SortedNums = lists:sort(Nums),
      three_sum_helper(SortedNums, 0, [])
  end.

three_sum_helper(Nums, Index, Acc) ->
  case Index >= length(Nums) - 2 of
    true ->
      lists:reverse(lists:usort(Acc));
    false ->
      Num = lists:nth(Index + 1, Nums),
      NewAcc = find_two_sum(Nums, Index + 1, -Num, Acc),
      three_sum_helper(Nums, Index + 1, NewAcc)
  end.

find_two_sum(Nums, Left, Target, Acc) ->
  find_two_sum_helper(Nums, Left, length(Nums), Target, Acc).

find_two_sum_helper(Nums, Left, Right, Target, Acc) ->
  case Left >= Right - 1 of
    true ->
      Acc;
    false ->
      LNum = lists:nth(Left + 1, Nums),
      RNum = lists:nth(Right, Nums),
      Sum = LNum + RNum,
      case Sum of
        Target ->
          FNum = lists:nth(Left, Nums),
          NewAcc = [[FNum, LNum, RNum] | Acc],
          find_two_sum_helper(Nums, Left + 1, Right - 1, Target, NewAcc);
        _ when Sum < Target ->
          find_two_sum_helper(Nums, Left + 1, Right, Target, Acc);
        _ ->
          find_two_sum_helper(Nums, Left, Right - 1, Target, Acc)
      end
  end.