-module(solution).
-export([count_vowel_permutation/1]).

count_vowel_permutation(N) ->
    Mod = 1000000007,
    DP = lists:duplicate(5, 1),
    count_vowel_permutation(N, 1, DP, Mod).

count_vowel_permutation(N, I, DP, Mod) when I =:= N ->
    lists:sum(DP) rem Mod;
count_vowel_permutation(N, I, DP, Mod) ->
    [A, E, I0, O, U] = DP,
    NewA = (E + I0 + U) rem Mod,
    NewE = (A + I0) rem Mod,
    NewI = (E + O) rem Mod,
    NewO = I0 rem Mod,
    NewU = (I0 + O) rem Mod,
    NewDP = [NewA, NewE, NewI, NewO, NewU],
    count_vowel_permutation(N, I + 1, NewDP, Mod).