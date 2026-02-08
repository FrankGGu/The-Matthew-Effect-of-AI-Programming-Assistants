-module(k_inverse_pairs_array).
-export([findNumberOfArrays/1]).

findNumberOfArrays(N) ->
    Mod = 1000000007,
    DP = array:new([{size, N+1}, {default, 0}]),
    DP1 = array:set(0, 1, DP),
    findNumberOfArrays(N, DP1, Mod).

findNumberOfArrays(0, DP, _) ->
    array:get(0, DP);
findNumberOfArrays(N, DP, Mod) ->
    DP2 = array:new([{size, N+1}, {default, 0}]),
    lists:foreach(fun(I) -> array:set(I, array:get(I, DP), DP2) end, lists:seq(0, N)),
    lists:foreach(fun(K) ->
        if
            K > 0 ->
                array:set(K, (array:get(K, DP) + array:get(K-1, DP) - array:get(K-1, DP) + Mod) rem Mod, DP2);
            true ->
                ok
        end
    end, lists:seq(0, N)),
    findNumberOfArrays(N-1, DP2, Mod).