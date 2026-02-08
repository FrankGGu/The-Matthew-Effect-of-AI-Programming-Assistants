-module(sum_beauty).
-export([sum_of_beauties/1]).

sum_of_beauties(Nums) ->
  N = length(Nums),
  {LeftMax, RightMin} = precompute(Nums),
  sum_of_beauties_helper(Nums, LeftMax, RightMin, 1, N - 2, 0).

sum_of_beauties_helper(_, _, _, I, J, Acc) when I > J ->
  Acc;
sum_of_beauties_helper(Nums, LeftMax, RightMin, I, J, Acc) ->
  Num = lists:nth(I + 1, Nums),
  Beauty =
    case
      LeftMax ! (I - 1) < Num andalso Num < RightMin ! (I + 1) ->
        2;
      lists:nth(I, Nums) < Num andalso Num < lists:nth(I + 2, Nums) ->
        1;
      true ->
        0
    end,
  sum_of_beauties_helper(Nums, LeftMax, RightMin, I + 1, J, Acc + Beauty).

precompute(Nums) ->
  N = length(Nums),
  LeftMax = precompute_left_max(Nums, N),
  RightMin = precompute_right_min(Nums, N),
  {LeftMax, RightMin}.

precompute_left_max(Nums, N) ->
  precompute_left_max_helper(Nums, N, [], 0).

precompute_left_max_helper(_, 0, Acc, _) ->
  lists:reverse(Acc);
precompute_left_max_helper(Nums, I, Acc, Max) ->
  Num = lists:nth(I, Nums),
  NewMax = max(Max, Num),
  precompute_left_max_helper(Nums, I - 1, [NewMax | Acc], NewMax).

precompute_right_min(Nums, N) ->
  precompute_right_min_helper(Nums, N, [], 100001).

precompute_right_min_helper(_, 0, Acc, _) ->
  lists:reverse(Acc);
precompute_right_min_helper(Nums, I, Acc, Min) ->
  Num = lists:nth(I, Nums),
  NewMin = min(Min, Num),
  precompute_right_min_helper(Nums, I - 1, [NewMin | Acc], NewMin).