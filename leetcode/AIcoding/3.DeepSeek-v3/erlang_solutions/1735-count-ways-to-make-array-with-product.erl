-module(solution).
-export([ways_to_fill_array/2]).

ways_to_fill_array(Queries, N) ->
    MaxK = lists:max([K || {_, K} <- Queries]),
    Sieve = sieve(MaxK),
    [count_ways(N, K, Sieve) || {_, K} <- Queries].

sieve(Max) ->
    Sieve = array:new([{size, Max + 1}, {default, []}]),
    lists:foldl(fun(P, S) ->
                    lists:foldl(fun(M, Acc) ->
                                    case array:get(M, Acc) of
                                        [] -> array:set(M, [P], Acc);
                                        Factors -> array:set(M, [P | Factors], Acc)
                                    end
                                end, S, lists:seq(P, Max, P))
                end, Sieve, lists:seq(2, Max)).

count_ways(N, K, Sieve) ->
    Factors = array:get(K, Sieve),
    Grouped = group_factors(Factors),
    lists:foldl(fun({_, Cnt}, Acc) ->
                    (Acc * comb(N + Cnt - 1, Cnt)) rem 1000000007
                end, 1, Grouped).

group_factors(Factors) ->
    lists:foldl(fun(F, Acc) ->
                    case lists:keyfind(F, 1, Acc) of
                        false -> [{F, 1} | Acc];
                        {F, Cnt} -> lists:keyreplace(F, 1, Acc, {F, Cnt + 1})
                    end
                end, [], Factors).

comb(N, K) ->
    if
        K > N -> 0;
        true -> comb(N, K, 1, 1)
    end.

comb(_, 0, Acc, _) -> Acc;
comb(N, K, Acc, I) ->
    comb(N, K - 1, (Acc * (N - K + 1) div I) rem 1000000007, I + 1).