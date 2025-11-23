-module(maximum_strong_pair_xor_ii).
-export([maximum_strong_pair_xor_ii/1]).

maximum_strong_pair_xor_ii(Nums) ->
  maximum_strong_pair_xor_ii(Nums, 0, 0).

maximum_strong_pair_xor_ii([], MaxXor, _) ->
  MaxXor;
maximum_strong_pair_xor_ii([H|T], MaxXor, N) ->
  MaxXor1 = lists:foldl(
    fun(X, Acc) ->
      if abs(H - X) =< H then
        max(Acc, H bxor X)
      else
        Acc
      end
    end,
    MaxXor,
    lists:sublist([H|T], N+1)
  ),
  maximum_strong_pair_xor_ii(T, MaxXor1, N+1).