-module(maximum_triplet_value).
-export([maximum_triplet_value/1]).

maximum_triplet_value(Nums) ->
  maximum_triplet_value(Nums, 0, 0, 0, 0).

maximum_triplet_value([], _, _, _, Max) ->
  Max;
maximum_triplet_value([Num | Rest], A, B, C, Max) ->
  NewMax = max(Max, (A - B) * C),
  maximum_triplet_value(Rest, max(A, Num), max(B, A), max(C, Num), NewMax).

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.