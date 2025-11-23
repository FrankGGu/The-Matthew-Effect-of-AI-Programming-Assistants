-module(greatest_common_divisor_of_strings).
-export([gcd_of_strings/2]).

gcd_of_strings(Str1, Str2) ->
    L1 = string:len(Str1),
    L2 = string:len(Str2),

    if (Str1 ++ Str2) == (Str2 ++ Str1) ->
        G = math:gcd(L1, L2),
        string:substr(Str1, 1, G);
    true ->
        ""
    end.