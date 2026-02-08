-module(left_right_sum_differences).
-export([solve/1]).

solve(Nums) ->
  N = length(Nums),
  LeftSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Nums)),
  RightSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Nums),
  Result = [abs(lists:nth(I, LeftSum) - lists:nth(I, RightSum)) || I <- lists:seq(1, N)],
  Result.