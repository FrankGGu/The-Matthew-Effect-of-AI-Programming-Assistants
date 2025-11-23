-module(solution).
-export([find_prefix_score/1]).

find_prefix_score(Nums) ->
  find_prefix_score(Nums, 0, 0, []).

find_prefix_score([], _, _, Acc) ->
  lists:reverse(Acc);
find_prefix_score([H|T], Max, Sum, Acc) ->
  NewMax = max(H, Max),
  NewSum = Sum + H + NewMax,
  find_prefix_score(T, NewMax, NewSum, [NewSum|Acc]).