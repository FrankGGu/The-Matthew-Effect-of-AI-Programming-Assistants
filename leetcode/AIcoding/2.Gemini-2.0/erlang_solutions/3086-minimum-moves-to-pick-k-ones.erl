-module(minimum_moves_k_ones).
-export([min_moves/2]).

min_moves(Nums, K) ->
  Ones = lists:filter(fun(X) -> lists:nth(X, Nums) == 1 end, lists:seq(1, length(Nums))),
  min_moves_helper(Ones, K).

min_moves_helper(Ones, K) ->
  Len = length(Ones),
  case Len < K of
    true -> 0;
    false ->
      lists:foldl(fun(I, Acc) ->
                      Min = calculate_moves(Ones, I, K),
                      min(Acc, Min)
                  end,
                  infinity,
                  lists:seq(1, Len - K + 1))
  end.

calculate_moves(Ones, Start, K) ->
  MedianIndex = Start + (K - 1) div 2,
  Median = lists:nth(MedianIndex, Ones),
  lists:foldl(fun(I, Acc) ->
                      Acc + abs(lists:nth(I, Ones) - Median - (I - MedianIndex))
                  end,
                  0,
                  lists:seq(Start, Start + K - 1)).

min(A, B) ->
  if A < B -> A; true -> B end.

infinity() -> 100000000000000.