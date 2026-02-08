-module(apply_operations).
-export([apply_operations/1]).

apply_operations(Nums) ->
  apply_operations_helper(Nums, []).

apply_operations_helper([], Acc) ->
  lists:reverse(Acc);
apply_operations_helper([A, B | Rest], Acc) when A == B ->
  apply_operations_helper([0 | Rest], [A * 2 | Acc]);
apply_operations_helper([A, B | Rest], Acc) ->
  apply_operations_helper([B | Rest], [A | Acc]);
apply_operations_helper([A], Acc) ->
  lists:reverse(Acc ++ [A]);

apply_operations(Nums) ->
  NewNums = lists:foldl(fun(I, Acc) ->
                                  case lists:nth(I, Nums) == lists:nth(I+1, Nums) of
                                    true ->
                                      lists:nth(I, Nums) * 2;
                                      lists:nth(I+1, Nums) = 0;
                                    false ->
                                      Acc
                                  end
                              end, Nums, lists:seq(1, length(Nums) - 1)),
  NonZeroNums = [X || X <- NewNums, X /= 0],
  NonZeroNums ++ lists:duplicate(length(Nums) - length(NonZeroNums), 0).