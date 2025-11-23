-module(bitwise_ors_of_subarrays).
-export([subarray_bitwise_ORs/1]).

subarray_bitwise_ORs(A) ->
  subarray_bitwise_ORs(A, [], []).

subarray_bitwise_ORs([], _, Set) ->
  lists:usort(Set);
subarray_bitwise_ORs([H|T], Prev, Set) ->
  NewPrev = lists:foldl(fun(X, Acc) ->
                                  NewVal = X bor H,
                                  [NewVal | Acc]
                          end, [H], Prev),
  subarray_bitwise_ORs(T, NewPrev, lists:usort(Set ++ NewPrev)).