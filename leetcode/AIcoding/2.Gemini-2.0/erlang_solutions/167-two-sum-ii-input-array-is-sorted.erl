-module(two_sum_ii).
-export([two_sum/2]).

two_sum(Nums, Target) ->
  two_sum_helper(Nums, Target, 1, length(Nums)).

two_sum_helper(Nums, Target, L, R) when L >= R ->
  [];
two_sum_helper(Nums, Target, L, R) ->
  case Nums[L] + Nums[R] of
    Target ->
      [L, R];
    Sum when Sum < Target ->
      two_sum_helper(Nums, Target, L + 1, R);
    _ ->
      two_sum_helper(Nums, Target, L, R - 1)
  end.