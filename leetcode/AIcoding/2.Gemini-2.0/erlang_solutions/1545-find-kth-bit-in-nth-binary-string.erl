-module(find_kth_bit).
-export([find_kth_bit/2]).

find_kth_bit(N, K) ->
  find_kth_bit_helper(N, K).

find_kth_bit_helper(1, 1) ->
  0;
find_kth_bit_helper(N, K) ->
  Len = (1 bsl N) - 1,
  Mid = Len div 2 + 1,
  if K =:= Mid ->
    1;
  K < Mid ->
    find_kth_bit_helper(N - 1, K);
  true ->
    LenMinusKPlus1 = Len - K + 1,
    case find_kth_bit_helper(N - 1, LenMinusKPlus1) of
      0 -> 1;
      1 -> 0
    end
  end.