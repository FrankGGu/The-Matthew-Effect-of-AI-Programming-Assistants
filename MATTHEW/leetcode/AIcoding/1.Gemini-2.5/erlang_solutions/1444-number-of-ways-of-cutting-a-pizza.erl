-module(solution).
-export([ways/2]).

-define(MOD, 1000000007).

ways(Pizza, K) ->
    R = length(Pizza),
    C = length(hd(Pizza)),

    AppleCountTuple = make_apple_count_tuple(Pizza, R, C),

    Memo = ets:new(pizza_memo, [set, protected, {read_concurrency, true}]),

    Result = dp(K, 0, 0, R, C, AppleCountTuple, Memo),
    ets:delete(Memo),
    Result.

dp(K_rem, R_start, C_start, R, C, AppleCountTuple, Memo) ->
    Key = {K_rem, R_start, C_start},
    case ets:lookup(Memo, Key) of
        [{Key, Value}] ->
            Value;
        [] ->
            Value =
                if
                    K_rem == 0 ->
                        if
                            get_apples_in_rect(R_start, C_start, R - 1, C - 1, AppleCountTuple) > 0 ->
                                1;
                            true ->
                                0
                        end;
                    true ->
                        TotalWays = 0,
                        TotalWays1 = lists:foldl(
                            fun(Nr, Acc) ->
                                if
                                    get_apples_in_rect(R_start, C_start, Nr - 1, C - 1, AppleCountTuple) > 0 ->
                                        (Acc + dp(K_rem - 1, Nr, C_start, R, C, AppleCountTuple, Memo)) rem ?MOD;
                                    true ->
                                        Acc
                                end
                            end,
                            TotalWays,
                            lists:seq(R_start + 1, R - 1)
                        ),
                        TotalWays2 = lists:foldl(
                            fun(Nc, Acc) ->
                                if
                                    get_apples_in_rect(R_start, C_start, R - 1, Nc - 1, AppleCountTuple) > 0 ->
                                        (Acc + dp(K_rem - 1, R_start, Nc, R, C, AppleCountTuple, Memo)) rem ?MOD;
                                    true ->
                                        Acc
                                end
                            end,
                            TotalWays1,
                            lists:seq(C_start + 1, C - 1)
                        ),
                        TotalWays2
                end,
            ets:insert(Memo, {Key, Value}),
            Value
    end.

make_apple_count_tuple(Pizza, R, C) ->
    GridList = lists:duplicate(R + 1, lists:duplicate(C + 1, 0)),

    FilledGridList = lists:foldr(
        fun(RowIdx, CurrentGridAcc) ->
            lists:foldr(
                fun(ColIdx, CurrentGridAcc2) ->
                    PizzaChar = element(ColIdx + 1, lists:nth(RowIdx + 1, Pizza)),
                    Apple = if PizzaChar == $A -> 1; true -> 0 end,

                    ValBelow = element(ColIdx + 1, lists:nth(RowIdx + 2, CurrentGridAcc2)),
                    ValRight = element(ColIdx + 2, lists:nth(RowIdx + 1, CurrentGridAcc2)),
                    ValDiag = element(ColIdx + 2, lists:nth(RowIdx + 2, CurrentGridAcc2)),

                    NewVal = Apple + ValBelow + ValRight - ValDiag,

                    lists:replace_nth(
                        RowIdx + 1,
                        lists:replace_nth(ColIdx + 1, NewVal, lists:nth(RowIdx + 1, CurrentGridAcc2)),
                        CurrentGridAcc2
                    )
                end,
                CurrentGridAcc,
                lists:seq(C - 1, 0, -1)
            )
        end,
        GridList,
        lists:seq(R - 1, 0, -1)
    ),

    list_to_tuple(lists:map(fun list_to_tuple/1, FilledGridList)).

get_apples_in_rect(R1, C1, R2, C2, AppleCountTuple) ->
    Val_r1_c1 = element(C1 + 1, element(R1 + 1, AppleCountTuple)),
    Val_r2p1_c1 = element(C1 + 1, element(R2 + 1 + 1, AppleCountTuple)),
    Val_r1_c2p1 = element(C2 + 1 + 1, element(R1 + 1, AppleCountTuple)),
    Val_r2p1_c2p1 = element(C2 + 1 + 1, element(R2 + 1 + 1, AppleCountTuple)),

    Val_r1_c1 - Val_r2p1_c1 - Val_r1_c2p1 + Val_r2p1_c2p1.