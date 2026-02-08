-module(find_kth_character).
-export([find_kth_bit/2]).

find_kth_bit(N, K) ->
  find_kth_bit_helper(N, K, "0").

find_kth_bit_helper(0, K, S) ->
  list_to_integer([S !! (K - 1)]);
find_kth_bit_helper(N, K, S) ->
  S_inv = lists:map(fun(C) -> if C == '0' -> '1'; true -> '0' end end, lists:reverse(S)),
  Next_S = S ++ "1" ++ S_inv,
  Len = length(Next_S),
  if K > Len then
    find_kth_bit_helper(N - 1, K, S)
  else
    find_kth_bit_helper(N - 1, K, S).