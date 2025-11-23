-module(solution).
-export([count_palindromic_subsequences/1]).

count_palindromic_subsequences(S) ->
    N = length(S),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    Mod = 1000000007,
    lists:foldl(
        fun(I, _) ->
            lists:foldl(
                fun(J, _) ->
                    if
                        I > J -> ok;
                        I == J ->
                            Old = array:get(I, DP),
                            New = array:set(J, 1, Old),
                            array:set(I, New, DP);
                        true ->
                            S1 = lists:nth(I + 1, S),
                            S2 = lists:nth(J + 1, S),
                            if
                                S1 == S2 ->
                                    Old = array:get(I, DP),
                                    V1 = array:get(I + 1, array:get(J - 1, DP)),
                                    V2 = array:get(I + 1, array:get(J, DP)),
                                    V3 = array:get(I, array:get(J - 1, DP)),
                                    Val = (V1 + V2 + V3 - V1 + 1) rem Mod,
                                    New = array:set(J, Val, Old),
                                    array:set(I, New, DP);
                                true ->
                                    Old = array:get(I, DP),
                                    V1 = array:get(I + 1, array:get(J, DP)),
                                    V2 = array:get(I, array:get(J - 1, DP)),
                                    V3 = array:get(I + 1, array:get(J - 1, DP)),
                                    Val = (V1 + V2 - V3) rem Mod,
                                    New = array:set(J, Val, Old),
                                    array:set(I, New, DP)
                            end
                    end
                end,
                ok,
                lists:seq(0, N - 1)
            )
        end,
        ok,
        lists:seq(0, N - 1)
    ),
    (array:get(0, array:get(N - 1, DP)) rem Mod.