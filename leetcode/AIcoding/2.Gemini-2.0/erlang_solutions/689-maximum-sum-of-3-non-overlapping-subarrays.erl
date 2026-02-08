-module(maximum_sum_3_non_overlapping_subarrays).
-export([max_sum_three_subarrays/2]).

max_sum_three_subarrays(Nums, K) ->
  N = length(Nums),
  PrefixSums = [lists:sum(lists:sublist(Nums, 1, I)) || I <- lists:seq(1, N)],
  Left = lists:map(fun(I) ->
    lists:foldl(fun(J, Acc) ->
      if (I - K + 1 >= 1 andalso PrefixSums[I] - (if I - K =:= 0 then 0 else PrefixSums[I - K]) > PrefixSums[Acc] - (if Acc - K =:= 0 then 0 else PrefixSums[Acc - K]) ) ->
        I - K + 1;
      true ->
        Acc
      end
    end, K, lists:seq(K, I))
  end, lists:seq(K, N - 2 * K)),

  Right = lists:reverse(lists:map(fun(I) ->
    lists:foldl(fun(J, Acc) ->
      if (I + K - 1 <= N andalso PrefixSums[I + K - 1] - PrefixSums[I - 1] >= PrefixSums[Acc + K - 1] - PrefixSums[Acc - 1]) ->
        I;
      true ->
        Acc
      end
    end, N - 2 * K + 1, lists:seq(I, N - 2 * K))
  end, lists:reverse(lists:seq(K + 2 * K -1 , N - K + 1)))),

  MiddleIndices = lists:seq(K, N - 2 * K),
  Result = lists:foldl(fun(M, {MaxSum, Indices}) ->
    L = Left[M - K + 1],
    R = Right[M - K + 1],
    Sum = (PrefixSums[L + K - 1] - (if L - 1 =:= 0 then 0 else PrefixSums[L - 1])) + (PrefixSums[M + K - 1] - PrefixSums[M - 1]) + (PrefixSums[R + K - 1] - PrefixSums[R - 1]),
    if Sum > MaxSum ->
      {Sum, [L - 1, M - 1, R - 1]};
    true ->
      {MaxSum, Indices}
    end
  end, {0, []}, MiddleIndices),

  lists:nth(2, Result).