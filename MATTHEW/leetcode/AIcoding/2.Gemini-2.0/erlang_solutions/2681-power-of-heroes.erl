-module(power_of_heroes).
-export([sum_of_power/1]).

sum_of_power(Nums) ->
  sum_of_power(Nums, 0, 0).

sum_of_power([], _, Sum) ->
  Sum rem 1000000007;
sum_of_power([H|T], PrevSum, Sum) ->
  NewPrevSum = (PrevSum + H) rem 1000000007,
  NewSum = (Sum + (lists:max(T ++ [H]) * lists:min(T ++ [H]) rem 1000000007) rem 1000000007 + (H * H rem 1000000007 * (length(T)+1) rem 1000000007) rem 1000000007 +  (H * PrevSum rem 1000000007 * 2 rem 1000000007) rem 1000000007) rem 1000000007,
  sum_of_power(T, NewPrevSum, NewSum).