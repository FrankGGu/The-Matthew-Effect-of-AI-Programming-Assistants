-module(put_marbles).
-export([put_marbles/2]).

put_marbles(Weights, K) ->
  N = length(Weights),
  SortedPairs = lists:sort([Weights[I] + Weights[I + 1] || I <- lists:seq(1, N - 1)]),
  Sum = lists:sum(lists:sublist(SortedPairs, 1, K - 1)),
  TotalSum = lists:sum(Weights),
  First = lists:nth(1, Weights),
  Last = lists:last(Weights),
  TotalSum + First + Last - Sum - lists:last(SortedPairs).