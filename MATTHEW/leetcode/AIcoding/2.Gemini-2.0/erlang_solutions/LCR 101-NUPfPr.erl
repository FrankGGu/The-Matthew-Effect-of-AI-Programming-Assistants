-module(partition_equal_subset_sum).
-export([can_partition/1]).

can_partition(Nums) ->
  Sum = lists:sum(Nums),
  if Sum rem 2 /= 0 then
    false
  else
    Target = Sum div 2,
    N = length(Nums),
    DP = array:new([N + 1, Target + 1], {false}),
    array:set({0, 0}, true, DP),
    can_partition_helper(Nums, N, Target, DP)
  end.

can_partition_helper(Nums, N, Target, DP) ->
  lists:foldl(fun(Num, Acc) ->
                  lists:foldl(fun(Cap, Acc2) ->
                                  if Cap >= Num then
                                    Prev = array:get({Acc - 1, Cap - Num}, DP) orelse array:get({Acc - 1, Cap}, DP),
                                    array:set({Acc, Cap}, Prev, DP),
                                    Prev
                                  else
                                    Prev = array:get({Acc - 1, Cap}, DP),
                                    array:set({Acc, Cap}, Prev, DP),
                                    Prev
                                  end
                              end,
                              false,
                              lists:seq(1, Target))
              end,
              false,
              lists:seq(1, N)),
  array:get({length(Nums), Target}, DP).