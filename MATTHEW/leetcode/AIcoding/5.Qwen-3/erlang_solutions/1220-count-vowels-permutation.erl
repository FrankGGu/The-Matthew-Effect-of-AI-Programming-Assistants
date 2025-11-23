-module(count_vowels_permutation).
-export([count_vowels/1]).

count_vowels(N) ->
    count_vowels(N, 0, 0, 0, 0, 0).

count_vowels(0, a, e, i, o, u) -> a + e + i + o + u;
count_vowels(N, a, e, i, o, u) ->
    NewA = e + i + u,
    NewE = a + i,
    NewI = e + o,
    NewO = i,
    NewU = i + o,
    count_vowels(N - 1, NewA, NewE, NewI, NewO, NewU).