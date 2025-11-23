-module(solution).
-export([deep_dark_fraction/1]).

deep_dark_fraction(Fraction) ->
    {N, D} = solve_continued_fraction(Fraction),
    [N, D].

solve_continued_fraction([A]) ->
    {A, 1};
solve_continued_fraction([A | Rest]) ->
    {N_sub, D_sub} = solve_continued_fraction(Rest),
    Num = A * N_sub + D_sub,
    Den = N_sub,
    G = gcd(Num, Den),
    {Num div G, Den div G}.

gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).