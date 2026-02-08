-module(maximum_frequency).
-export([max_frequency/2]).

max_frequency(Nums, K) ->
  max_frequency(lists:sort(Nums), K, 0, 0, 0).

max_frequency(Nums, K, L, R, MaxFreq) when R >= length(Nums) ->
  max(MaxFreq, R - L);
max_frequency(Nums, K, L, R, MaxFreq) ->
  case K >= (lists:nth(R + 1, Nums) - lists:nth(L + 1, Nums)) * (R - L) of
    true ->
      max_frequency(Nums, K - (lists:nth(R + 1, Nums) - lists:nth(L + 1, Nums)) * (R - L), L, R + 1, MaxFreq);
    false ->
      max_frequency(Nums, K - (lists:nth(R + 1, Nums) - lists:nth(L + 1, Nums)) + lists:nth(L + 1, Nums), L + 1, R, MaxFreq)
  end.

max(A, B) ->
  if A > B -> A;
  true -> B
  end.