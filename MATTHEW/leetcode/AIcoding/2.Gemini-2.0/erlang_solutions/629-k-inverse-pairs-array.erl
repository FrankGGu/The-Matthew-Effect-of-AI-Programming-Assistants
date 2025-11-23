-module(k_inverse_pairs).
-export([k_inverse_pairs/2]).

k_inverse_pairs(N, K) ->
  Mod = 1000000007,
  DP = array:new([0, N+1, K+1], {fixed, 0}),
  array:set(1, 0, 1, DP),

  for(I = 2, I =< N, I,
    begin
      Sum = 0,
      for(J = 0, J =< K, J,
        begin
          Sum = (Sum + array:get(I-1, J, DP)) rem Mod,
          array:set(I, J, Sum, DP),
          if (J >= I) ->
            Sum = (Sum - array:get(I-1, J-I, DP) + Mod) rem Mod,
            array:set(I, J, Sum, DP)
          end
        end
      end),
  array:get(N, K, DP).