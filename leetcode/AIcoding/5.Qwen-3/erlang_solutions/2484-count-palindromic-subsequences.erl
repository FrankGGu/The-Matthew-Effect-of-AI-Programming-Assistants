-module(count_palindromic_subsequences).
-export([count_palindromic_subsequences/1]).

count_palindromic_subsequences(S) ->
    N = length(S),
    DP = array:new(N, {default, 0}),
    DP1 = array:new(N, {default, 0}),
    DP2 = array:new(N, {default, 0}),
    count_palindromic_subsequences(S, N, DP, DP1, DP2).

count_palindromic_subsequences(_, 0, _, _, _) -> 0;
count_palndromic_subsequences(S, N, DP, DP1, DP2) ->
    I = N - 1,
    Char = lists:nth(I + 1, S),
    DPNew = array:set(I, 1, DP),
    DP1New = array:set(I, 1, DP1),
    DP2New = array:set(I, 1, DP2),
    J = I - 1,
    count_palindromic_subsequences(S, N, DPNew, DP1New, DP2New, J, I).

count_palindromic_subsequences(_, _, DP, DP1, DP2, J, I) when J < 0 ->
    count_palindromic_subsequences(S, N-1, DP, DP1, DP2);
count_palindromic_subsequences(S, N, DP, DP1, DP2, J, I) ->
    CharJ = lists:nth(J + 1, S),
    if
        CharJ == Char ->
            Count = array:get(J, DP) + 1,
            NewDP = array:set(I, Count, DP),
            NewDP1 = array:set(I, array:get(J, DP1) + 1, DP1),
            NewDP2 = array:set(I, array:get(J, DP2) + 1, DP2),
            count_palindromic_subsequences(S, N, NewDP, NewDP1, NewDP2, J-1, I);
        true ->
            count_palindromic_subsequences(S, N, DP, DP1, DP2, J-1, I)
    end.