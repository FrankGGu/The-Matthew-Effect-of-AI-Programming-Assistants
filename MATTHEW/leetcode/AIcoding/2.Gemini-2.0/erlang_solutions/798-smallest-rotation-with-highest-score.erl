-module(smallest_rotation).
-export([k_rotate/1]).

k_rotate(nums) ->
  N = length(nums),
  bad = lists:seq(1, N, 0),
  Bad = lists:foldl(
    fun (I, Acc) ->
      Val = lists:nth(I, nums),
      Diff = (I - Val - 1),
      Shift = if Diff >= 0 then Diff else Diff + N end,
      lists:nth(Shift + 1, Acc) - 1
    end,
    bad,
    lists:seq(1, N)
  ),
  lists:keyfind(lists:max(Bad), 2, lists:zip(lists:seq(0, N - 1), Bad)) ! 1.