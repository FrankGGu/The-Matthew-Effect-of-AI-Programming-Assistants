-module(solution).
-export([beautiful_partitions/2]).

beautiful_partitions(S, K) ->
    PrimeSet = sets:from_list([$2, $3, $5, $7]),
    N = length(S),
    DP = array:new([{size, N + 1}, {default, array:new([{size, K + 1}, {default, 0}])}]),
    DP1 = array:set(0, array:set(0, 1, array:get(0, DP)), DP,
    lists:foldl(fun(I, AccDP) ->
        lists:foldl(fun(J, InnerDP) ->
            case J =< I andalso sets:is_element(lists:nth(I, S), PrimeSet) andalso 
                 (I == N orelse not sets:is_element(lists:nth(I + 1, S), PrimeSet)) of
                true ->
                    Val = lists:sum([array:get(K1, array:get(I - L, InnerDP)) || 
                          L <- lists:seq(1, I), K1 <- [J - 1],
                          I - L >= 0, K1 >= 0,
                          sets:is_element(lists:nth(I - L + 1, S), PrimeSet),
                          (I - L == 0 orelse not sets:is_element(lists:nth(I - L, S), PrimeSet))]),
                    array:set(I, array:set(J, Val rem 1000000007, array:get(I, InnerDP)), InnerDP);
                false ->
                    InnerDP
            end
        end, AccDP, lists:seq(1, K))
    end, DP1, lists:seq(1, N)),
    array:get(K, array:get(N, DP)) rem 1000000007.