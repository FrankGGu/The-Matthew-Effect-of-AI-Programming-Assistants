-module(sum_absolute_differences).
-export([get_sum_absolute_differences/1]).

get_sum_absolute_differences(Nums) ->
  N = length(Nums),
  {PrefixSum, _} = lists:foldl(
    fun(Num, {Acc, Sum}) ->
      {Acc ++ [Sum + Num], Sum + Num}
    end,
    {[], 0},
    Nums
  ),
  lists:map(
    fun(I) ->
      Num = lists:nth(I + 1, Nums),
      (I * Num) - lists:nth(I + 1, PrefixSum) +
      (lists:last(PrefixSum) - lists:nth(I + 1, PrefixSum)) - ((N - I - 1) * Num)
    end,
    lists:seq(0, N - 1)
  ).