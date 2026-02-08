-module(mean_after_removal).
-export([trim_mean/1]).

trim_mean(Arr) ->
  N = length(Arr),
  K = trunc(N * 0.05),
  SortedArr = lists:sort(Arr),
  SubList = lists:sublist(SortedArr, K + 1, N - 2 * K),
  Sum = lists:sum(SubList),
  FloatSum = erlang:float(Sum),
  FloatLen = erlang:float(N - 2 * K),
  FloatSum / FloatLen.