-module(minimum_cost_array_permutation).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, []).

solve([], Acc) ->
  calculate_cost(Acc);
solve(Nums, Acc) ->
  lists:min([solve(lists:delete(N, Nums), [N|Acc]) || N <- Nums]).

calculate_cost([]) ->
  0;
calculate_cost([_]) ->
  0;
calculate_cost(Nums) ->
  calculate_cost(Nums, 0).

calculate_cost([H1, H2 | T], Acc) ->
  calculate_cost([H2 | T], Acc + abs(H1 - H2));
calculate_cost([_], Acc) ->
  Acc;
calculate_cost([], Acc) ->
  Acc.