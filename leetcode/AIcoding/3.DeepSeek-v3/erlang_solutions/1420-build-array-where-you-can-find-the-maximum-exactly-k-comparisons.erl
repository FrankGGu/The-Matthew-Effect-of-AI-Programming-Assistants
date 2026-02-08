-module(solution).
-export([num_of_arrays/3]).

num_of_arrays(N, M, K) ->
    Mod = 1000000007,
    DP = lists:duplicate(N + 1, lists:duplicate(M + 1, lists:duplicate(K + 1, 0))),
    DP1 = update_dp(DP, 1, 1, 1, 1),
    DP2 = fill_dp(DP1, N, M, K, Mod),
    sum_last_layer(DP2, N, M, K, Mod).

update_dp(DP, I, J, L, Val) ->
    Old = get_dp(DP, I, J, L),
    New = (Old + Val) rem 1000000007,
    set_dp(DP, I, J, L, New).

get_dp(DP, I, J, L) ->
    lists:nth(I, lists:nth(J, lists:nth(L, DP))).

set_dp(DP, I, J, L, Val) ->
    Layer = lists:nth(L, DP),
    Row = lists:nth(J, Layer),
    NewRow = lists:sublist(Row, I - 1) ++ [Val] ++ lists:nthtail(I, Row),
    NewLayer = lists:sublist(Layer, J - 1) ++ [NewRow] ++ lists:nthtail(J, Layer),
    lists:sublist(DP, L - 1) ++ [NewLayer] ++ lists:nthtail(L, DP).

fill_dp(DP, N, M, K, Mod) ->
    lists:foldl(fun(I, Acc1) ->
        lists:foldl(fun(J, Acc2) ->
            lists:foldl(fun(L, Acc3) ->
                case get_dp(Acc3, I, J, L) of
                    0 -> Acc3;
                    Curr ->
                        AddSame = (Curr * J) rem Mod,
                        Acc4 = lists:foldl(fun(J1, Acc5) ->
                            update_dp(Acc5, I + 1, J1, L, Curr)
                        end, Acc3, lists:seq(1, J)),
                        lists:foldl(fun(J1, Acc5) ->
                            update_dp(Acc5, I + 1, J1, L + 1, Curr)
                        end, Acc4, lists:seq(J + 1, M))
                end
            end, Acc2, lists:seq(1, K))
        end, Acc1, lists:seq(1, M))
    end, DP, lists:seq(1, N)).

sum_last_layer(DP, N, M, K, Mod) ->
    lists:foldl(fun(J, SumJ) ->
        lists:foldl(fun(L, SumL) ->
            (SumL + get_dp(DP, N, J, L)) rem Mod
        end, SumJ, lists:seq(1, K))
    end, 0, lists:seq(1, M)).