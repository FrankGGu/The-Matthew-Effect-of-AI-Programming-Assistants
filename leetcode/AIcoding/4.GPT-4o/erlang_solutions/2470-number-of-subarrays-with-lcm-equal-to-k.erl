-module(solution).
-export([subarrayLCM/2]).

subarrayLCM(A, K) ->
    subarrayLCM(A, K, 0, 1, 0).

subarrayLCM([], _, Count, _, _) ->
    Count;
subarrayLCM([H | T], K, Count, CurrentLCM, Length) ->
    NewLCM = lcm(CurrentLCM, H),
    if
        NewLCM > K ->
            subarrayLCM(T, K, Count, 1, 0);
        NewLCM == K ->
            subarrayLCM(T, K, Count + Length + 1, NewLCM, Length + 1);
        true ->
            subarrayLCM(T, K, Count, NewLCM, Length + 1)
    end.

lcm(X, Y) ->
    abs(X * Y) div gcd(X, Y).

gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).