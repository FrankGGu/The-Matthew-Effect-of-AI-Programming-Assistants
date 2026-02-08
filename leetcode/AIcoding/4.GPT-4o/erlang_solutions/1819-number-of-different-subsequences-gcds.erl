-module(solution).
-export([count_different_gcds/1]).

count_different_gcds(Numbers) ->
    UniqueNumbers = lists:usort(Numbers),
    MaxNum = lists:last(UniqueNumbers),
    GCDs = lists:seq(1, MaxNum),
    GCDCounts = lists:map(fun(G) -> count_gcd(UniqueNumbers, G) end, GCDs),
    lists:sum(GCDCounts).

count_gcd(Numbers, G) ->
    if
        lists:any(fun(X) -> X rem G =:= 0 end, Numbers) ->
            GCDs = lists:filter(fun(X) -> gcd(X, G) =:= G end, Numbers),
            if
                length(GCDs) > 0 -> 1;
                true -> 0
            end;
        true -> 0
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).