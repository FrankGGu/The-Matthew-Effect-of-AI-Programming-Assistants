-module(count_palindromic_subsequences).
-export([count_palindromic_subsequences/1]).

count_palindromic_subsequences(S) ->
  N = length(S),
  M = 1000000007,
  DP = array:new([N, N], {0}),

  % Initialize single characters as palindromes
  for (I <- 1 to N) do
    array:set({I-1, I-1}, 1, DP)
  end,

  % Fill DP table for lengths 2 to N
  for (Len <- 2 to N) do
    for (I <- 1 to N - Len + 1) do
      J = I + Len - 1,
      if lists:nth(I, S) == lists:nth(J, S) then
        Val = (array:get({I, J-2}, DP) + array:get({I+1, J-1}, DP) + 2) rem M,
        array:set({I-1, J-1}, Val, DP)
      else
        Val = (array:get({I, J-1}, DP) + array:get({I-1, J-2}, DP) - array:get({I, J-2}, DP)) rem M,
        array:set({I-1, J-1}, (Val + M) rem M, DP)
      end
    end
  end,

  array:get({0, N-1}, DP).