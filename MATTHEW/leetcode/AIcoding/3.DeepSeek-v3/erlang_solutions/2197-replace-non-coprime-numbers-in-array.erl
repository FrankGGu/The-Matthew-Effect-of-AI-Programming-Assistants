-module(solution).
-export([replace_non_coprimes/1]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

replace_non_coprimes(Nums) ->
    replace_non_coprimes(Nums, []).

replace_non_coprimes([], Stack) -> lists:reverse(Stack);
replace_non_coprimes([H | T], []) ->
    replace_non_coprimes(T, [H]);
replace_non_coprimes([H | T], [Top | Rest] = Stack) ->
    Gcd = gcd(H, Top),
    if
        Gcd > 1 ->
            Lcm = (H * Top) div Gcd,
            replace_non_coprimes([Lcm | T], Rest);
        true ->
            replace_non_coprimes(T, [H | Stack])
    end.