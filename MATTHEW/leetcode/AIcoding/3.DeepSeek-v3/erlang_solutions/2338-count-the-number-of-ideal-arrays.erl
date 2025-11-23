-module(solution).
-export([ideal_arrays/2]).

ideal_arrays(N, MaxValue) ->
    Mod = 1000000007,
    MaxK = 20,
    DP = lists:foldl(fun(_, Acc) -> maps:new() end, maps:new(), lists:seq(1, MaxK)),
    DP1 = lists:foldl(fun(Val, Acc) -> maps:put(Val, 1, Acc) end, maps:new(), lists:seq(1, MaxValue)),
    DP = DP1,
    Comb = precompute_comb(N, MaxK, Mod),
    lists:foldl(fun(K, Acc) ->
        DPK = get_dp_k(DP, K, MaxValue, Mod),
        C = maps:get(K - 1, Comb, 0),
        (Acc + (DPK * C) rem Mod) rem Mod
    end, 0, lists:seq(1, MaxK)).

get_dp_k(DP, K, MaxValue, Mod) ->
    if
        K == 1 -> maps:fold(fun(_, V, Acc) -> (Acc + V) rem Mod end, 0, DP);
        true ->
            NewDP = maps:new(),
            lists:foldl(fun(Val, Acc) ->
                Multiples = get_multiples(Val, MaxValue),
                lists:foldl(fun(M, AccIn) ->
                    Count = maps:get(M, DP, 0),
                    Current = maps:get(Val, NewDP, 0),
                    maps:put(Val, (Current + Count) rem Mod, NewDP)
                end, 0, Multiples),
                Acc
            end, 0, lists:seq(1, MaxValue)),
            get_dp_k(NewDP, K - 1, MaxValue, Mod)
    end.

get_multiples(Val, MaxValue) ->
    lists:filter(fun(X) -> X =< MaxValue end, lists:seq(2 * Val, MaxValue, Val)).

precompute_comb(N, K, Mod) ->
    Comb = maps:new(),
    Comb1 = maps:put(0, 1, Comb),
    lists:foldl(fun(I, Acc) ->
        Prev = maps:get(I - 1, Acc, 0),
        Current = (Prev * (N - I + 1) div I) rem Mod,
        maps:put(I, Current, Acc)
    end, Comb1, lists:seq(1, K)).