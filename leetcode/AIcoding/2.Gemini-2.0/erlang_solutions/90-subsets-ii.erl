-module(subsets_ii).
-export([subsets_with_dup/1]).

subsets_with_dup(Nums) ->
  lists:sort(
    lists:usort(
      [lists:sort(Sub) || Sub <- subsets(lists:sort(Nums))]
    )
  ).

subsets(Nums) ->
  subsets_helper(Nums, []).

subsets_helper([], Acc) ->
  [lists:reverse(Acc)];
subsets_helper([H|T], Acc) ->
  subsets_helper(T, Acc) ++ subsets_helper(T, [H|Acc]).