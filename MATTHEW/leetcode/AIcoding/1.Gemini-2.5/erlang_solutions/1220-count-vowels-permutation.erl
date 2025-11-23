-module(solution).
-export([count_vowel_permutations/1]).

count_vowel_permutations(N) ->
    MOD = 1000000007,
    count_vowel_permutations_iter(N, MOD).

count_vowel_permutations_iter(1, _MOD) ->
    5;
count_vowel_permutations_iter(N, MOD) ->
    A = 1,
    E = 1,
    I = 1,
    O = 1,
    U = 1,

    count_vowel_permutations_loop(2, N, A, E, I, O, U, MOD).

count_vowel_permutations_loop(K, N, A_prev, E_prev, I_prev, O_prev, U_prev, MOD) when K =< N ->
    A_curr = (E_prev + I_prev + U_prev) rem MOD,
    E_curr = (A_prev + I_prev) rem MOD,
    I_curr = (E_prev + O_prev) rem MOD,
    O_curr = (I_prev) rem MOD,
    U_curr = (I_prev + O_prev) rem MOD,

    count_vowel_permutations_loop(K + 1, N, A_curr, E_curr, I_curr, O_curr, U_curr, MOD);
count_vowel_permutations_loop(_K, _N, A_prev, E_prev, I_prev, O_prev, U_prev, MOD) ->
    (A_prev + E_prev + I_prev + O_prev + U_prev) rem MOD.