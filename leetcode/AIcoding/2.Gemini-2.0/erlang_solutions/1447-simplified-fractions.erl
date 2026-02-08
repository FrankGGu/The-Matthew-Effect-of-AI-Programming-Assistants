-module(simplified_fractions).
-export([simplifiedFractions/1]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

simplifiedFractions(N) ->
    simplifiedFractionsHelper(N, []).

simplifiedFractionsHelper(1, Acc) ->
    lists:reverse(Acc);
simplifiedFractionsHelper(N, Acc) ->
    NewFractions = [integer_to_list(I) ++ "/" ++ integer_to_list(N) || I <- lists:seq(1, N-1), gcd(I, N) == 1],
    simplifiedFractionsHelper(N-1, NewFractions ++ Acc).