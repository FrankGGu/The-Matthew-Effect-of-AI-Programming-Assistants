-module(solution).
-export([count_arrays/2]).

count_arrays(N, K) ->
    Mod = 1000000007,
    case N of
        1 -> 1;
        _ ->
            DP = array:new([{size, N}, {default, 0}]),
            DP1 = array:set(1, 1, DP),
            DP2 = array:set(2, 1, DP1),
            count_arrays_helper(N, K, 2, DP2, Mod)
    end.

count_arrays_helper(N, K, I, DP, Mod) when I == N ->
    array:get(I, DP);
count_arrays_helper(N, K, I, DP, Mod) ->
    Val = array:get(I - 1, DP),
    NewVal = (Val * (K + 1)) rem Mod,
    DP1 = array:set(I, NewVal, DP),
    count_arrays_helper(N, K, I + 1, DP1, Mod).