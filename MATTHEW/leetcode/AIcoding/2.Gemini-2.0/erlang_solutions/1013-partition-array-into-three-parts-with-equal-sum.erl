-module(partition_array_into_three_parts_with_equal_sum).
-export([canThreePartsEqualSum/1]).

canThreePartsEqualSum(A) ->
  Sum = lists:sum(A),
  if Sum rem 3 /= 0 ->
    false
  else
    Target = Sum div 3,
    canPartition(A, Target, 0, 0)
  end.

canPartition(_, _, 3, _) ->
  true;
canPartition([], _, _, _) ->
  false;
canPartition([H|T], Target, Count, CurrentSum) ->
  NewSum = CurrentSum + H,
  if NewSum == Target ->
    canPartition(T, Target, Count + 1, 0)
  else
    canPartition(T, Target, Count, NewSum)
  end.