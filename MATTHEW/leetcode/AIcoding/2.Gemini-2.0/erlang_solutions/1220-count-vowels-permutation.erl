-module(count_vowels_permutation).
-export([count_vowels_permutation/1]).

count_vowels_permutation(n) ->
  Mod = 1000000007,
  {A, E, I, O, U} = count_vowels_permutation_helper(n, 1, 1, 1, 1, 1, Mod),
  (A + E + I + O + U) rem Mod.

count_vowels_permutation_helper(N, A, E, I, O, U, Mod) when N =:= 1 ->
  {A, E, I, O, U};
count_vowels_permutation_helper(N, A, E, I, O, U, Mod) ->
  NewA = E rem Mod,
  NewE = (A + I) rem Mod,
  NewI = (A + E + O + U) rem Mod,
  NewO = (I + U) rem Mod,
  NewU = A rem Mod,
  count_vowels_permutation_helper(N - 1, NewA, NewE, NewI, NewO, NewU, Mod).