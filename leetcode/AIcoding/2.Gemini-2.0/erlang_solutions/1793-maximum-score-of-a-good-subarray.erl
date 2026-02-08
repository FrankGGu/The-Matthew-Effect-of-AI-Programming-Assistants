-module(maximum_score_of_a_good_subarray).
-export([maximum_score/2]).

maximum_score(Nums, K) ->
  maximum_score(Nums, K, 0, K, K, Nums[K+1], Nums[K+1], Nums[K+1]).

maximum_score(Nums, K, MaxScore, L, R, MinVal, Left, Right) when L =:= 1, R =:= length(Nums) ->
  max(MaxScore, MinVal * (R - L + 1));
maximum_score(Nums, K, MaxScore, L, R, MinVal, Left, Right) when L > 1, R < length(Nums) ->
  if Left > Right ->
    maximum_score(Nums, K, max(MaxScore, MinVal * (R - L + 1)), L - 1, R, min(MinVal, Nums[L]), Nums[L-1], Right);
  true ->
    maximum_score(Nums, K, max(MaxScore, MinVal * (R - L + 1)), L, R + 1, min(MinVal, Nums[R+1]), Left, Nums[R+1])
  end;
maximum_score(Nums, K, MaxScore, L, R, MinVal, Left, Right) when L > 1 ->
  maximum_score(Nums, K, max(MaxScore, MinVal * (R - L + 1)), L - 1, R, min(MinVal, Nums[L]), Nums[L-1], Right);
maximum_score(Nums, K, MaxScore, L, R, MinVal, Left, Right) when R < length(Nums) ->
  maximum_score(Nums, K, max(MaxScore, MinVal * (R - L + 1)), L, R + 1, min(MinVal, Nums[R+1]), Left, Nums[R+1]);
maximum_score(Nums, K, MaxScore, L, R, MinVal, Left, Right) ->
  max(MaxScore, MinVal * (R - L + 1)).