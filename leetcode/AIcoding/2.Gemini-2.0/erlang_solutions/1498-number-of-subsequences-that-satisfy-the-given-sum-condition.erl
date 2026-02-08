-module(number_subsequences).
-export([num_subseq/2]).

num_subseq(Nums, Target) ->
  lists:sort(Nums, fun(A, B) -> A < B end),
  num_subseq_helper(Nums, Target, 0, length(Nums) - 1).

num_subseq_helper(_Nums, _Target, L, R) when L > R ->
  0;
num_subseq_helper(Nums, Target, L, R) ->
  if
    lists:nth(L + 1, Nums) + lists:nth(R + 1, Nums) > Target ->
      num_subseq_helper(Nums, Target, L, R - 1);
    true ->
      (power(2, R - L) rem 1000000007) + num_subseq_helper(Nums, Target, L + 1, R) rem 1000000007
  end.

power(X, N) ->
  power_helper(X, N, 1).

power_helper(_, 0, Acc) ->
  Acc rem 1000000007;
power_helper(X, N, Acc) ->
  if
    N rem 2 == 0 ->
      power_helper((X * X) rem 1000000007, N div 2, Acc) rem 1000000007;
    true ->
      power_helper(X, N - 1, (Acc * X) rem 1000000007) rem 1000000007
  end.