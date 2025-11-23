-module(build_array_k_comparisons).
-export([num_of_arrays/3]).

num_of_arrays(N, M, K) ->
  num_of_arrays(N, M, K, array({true, N, M, K}, [], undefined)).

num_of_arrays(N, M, K, Memo) ->
  helper(N, M, K, Memo).

helper(0, _, 0, Memo) -> 1;
helper(0, _, _, Memo) -> 0;
helper(N, M, K, Memo) when N < 0 or K < 0 -> 0;
helper(N, M, K, Memo) ->
  case array:is_defined({N, M, K}, Memo) of
    true -> array:get({N, M, K}, Memo);
    false ->
      Result = (lists:foldl(
                  fun(I, Acc) ->
                    (helper(N - 1, I - 1, K - 1, Memo) +
                       lists:foldl(
                         fun(J, InnerAcc) ->
                           (helper(N - 1, I, K, Memo) + InnerAcc) rem 1000000007
                         end,
                         0,
                         lists:seq(1, I)
                       )) rem 1000000007
                    ) rem 1000000007 + Acc
                  end,
                  0,
                  lists:seq(1, M)
                )) rem 1000000007,
      array:set({N, M, K}, Result, Memo)
  end.