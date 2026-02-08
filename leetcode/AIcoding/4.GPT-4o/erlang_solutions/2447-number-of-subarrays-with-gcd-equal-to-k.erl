-module(solution).
-export([subarrayGCD/2]).

subarrayGCD(Numbers, K) ->
    Length = length(Numbers),
    subarrayGCD_helper(Numbers, K, Length, 0, 0).

subarrayGCD_helper([], _, _, _, Count) -> Count;
subarrayGCD_helper(Numbers, K, Length, Start, Count) ->
    if 
        Start >= Length -> 
            Count;
        true ->
            GCD = gcd_from_list(lists:sublist(Numbers, Start + 1)),
            NewCount = if GCD =:= K -> Count + 1; true -> Count end,
            subarrayGCD_helper(Numbers, K, Length, Start + 1, NewCount)
    end.

gcd_from_list(L) -> 
    lists:foldl(fun(X, Acc) -> gcd(X, Acc) end, 0, L).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).