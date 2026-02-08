-module(solution).
-export([permute/1]).

permute(Nums) ->
  lists:sort(permute_helper(Nums, [])).

permute_helper([], Acc) ->
  [lists:reverse(Acc)];
permute_helper(Nums, Acc) ->
  lists:flatten([permute_helper(lists:delete(N, Nums), [N|Acc]) || N <- Nums]).