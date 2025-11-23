-module(solution).
-export([count_sorted_vowel_strings/1]).

count_sorted_vowel_strings(N) ->
    A = 1,
    E = 1,
    I = 1,
    O = 1,
    U = 1,
    count_sorted_vowel_strings(N, A, E, I, O, U).

count_sorted_vowel_strings(1, A, E, I, O, U) ->
    A + E + I + O + U;

count_sorted_vowel_strings(N, A, E, I, O, U) ->
    NewA = A,
    NewE = A + E,
    NewI = A + E + I,
    NewO = A + E + I + O,
    NewU = A + E + I + O + U,
    count_sorted_vowel_strings(N - 1, NewA, NewE, NewI, NewO, NewU).