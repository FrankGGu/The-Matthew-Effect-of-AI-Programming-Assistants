-module(find_x_sum_ii).
-export([find_x_sum/2]).

find_x_sum(Nums, K) ->
  find_x_sum(Nums, K, 0, 0, []).

find_x_sum([], _K, Sum, Count, Acc) ->
  [Sum, Count] ++ lists:reverse(Acc);
find_x_sum(Nums, K, Sum, Count, Acc) ->
  N = length(Nums),
  if N < K ->
    [Sum, Count] ++ lists:reverse(Acc);
  true ->
    SubArray = lists:sublist(Nums, K),
    Max = lists:max(SubArray),
    NewSum = Sum + Max,
    NewCount = Count + 1,
    find_x_sum(tl(Nums), K, NewSum, NewCount, [Max|Acc])
  end.