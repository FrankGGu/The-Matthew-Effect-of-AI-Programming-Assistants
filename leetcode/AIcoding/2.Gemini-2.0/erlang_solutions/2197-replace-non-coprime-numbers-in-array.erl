-module(replace_non_coprime).
-export([replace_non_coprime/1]).

gcd(A, 0) -> A;
gcd(0, B) -> B;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> A * B div gcd(A, B).

replace_non_coprime(Nums) ->
    replace_non_coprime_helper(Nums, []).

replace_non_coprime_helper([], Acc) ->
    lists:reverse(Acc);
replace_non_coprime_helper([H|T], []) ->
    replace_non_coprime_helper(T, [H]);
replace_non_coprime_helper([H|T], [Last|Rest]) ->
    G = gcd(H, Last),
    if
        G > 1 ->
            NewLast = lcm(H, Last),
            replace_non_coprime_helper(T, [NewLast|Rest]);
        true ->
            replace_non_coprime_helper(T, [H, Last|Rest])
    end.