-module(solution).
-export([num_arrays/3]).

num_arrays(N, M, K) ->
    DP = array:new([{size, N + 1}, {default, array:new([{size, K + 1}, {default, 0}])}]),
    DP1 = array:set(1, array:set(0, 1, array:get(1, DP)), DP),
    DP2 = num_arrays_dp(2, N, M, K, DP1),
    array:get(K, array:get(N, DP2)).

num_arrays_dp(I, N, M, K, DP) when I > N ->
    DP;
num_arrays_dp(I, N, M, K, DP) ->
    NewRow = array:new([{size, K + 1}, {default, 0}]),
    NewRow1 = case I > 1 of
        true ->
            lists:foldl(fun(J, Acc) ->
                PrevRow = array:get(I - 1, DP),
                Same = (M - 1) * array:get(J, PrevRow) rem 1000000007,
                Diff = case J > 0 of
                    true -> array:get(J - 1, PrevRow);
                    false -> 0
                end,
                Total = (Same + Diff) rem 1000000007,
                array:set(J, Total, Acc)
            end, NewRow, lists:seq(0, K));
        false ->
            NewRow
    end,
    NewDP = array:set(I, NewRow1, DP),
    num_arrays_dp(I + 1, N, M, K, NewDP).