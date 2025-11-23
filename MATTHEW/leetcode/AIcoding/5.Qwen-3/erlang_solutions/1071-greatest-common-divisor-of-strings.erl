-module(gcd_of_strings).
-export([gcd_of_strings/2]).

gcd_of_strings(Str1, Str2) ->
    Min = min(length(Str1), length(Str2)),
    GCD = gcd(Min, abs(length(Str1) - length(Str2))),
    Sub = string:substr(Str1, 1, GCD),
    if
        is_gcd(Str1, Sub) andalso is_gcd(Str2, Sub) -> Sub;
        true -> ""
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

is_gcd(S, Sub) ->
    Len = length(Sub),
    N = length(S) div Len,
    lists:all(fun(_) -> S == lists:flatten(lists:duplicate(N, Sub)) end, lists:seq(1, 1)).