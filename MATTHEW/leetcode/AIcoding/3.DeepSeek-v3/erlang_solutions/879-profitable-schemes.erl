-module(solution).
-export([profitable_schemes/3]).

profitable_schemes(N, MinProfit, Group, Profit) ->
    Mod = 1000000007,
    DP = array:new([{size, N + 1}, {default, array:new([{size, MinProfit + 1}, {default, 0}])}]),
    DP1 = array:set(0, array:set(0, 1, array:get(0, DP)), DP),
    lists:foldl(
        fun({G, P}, Acc) ->
            lists:foldr(
                fun(I, DpAcc) ->
                    lists:foldr(
                        fun(J, InnerAcc) ->
                            case I + G =< N of
                                true ->
                                    NewJ = min(J + P, MinProfit),
                                    OldVal = array:get(NewJ, array:get(I + G, InnerAcc)),
                                    CurrVal = array:get(J, array:get(I, InnerAcc)),
                                    Updated = array:set(NewJ, (OldVal + CurrVal) rem Mod, array:get(I + G, InnerAcc)),
                                    array:set(I + G, Updated, InnerAcc);
                                false ->
                                    InnerAcc
                            end
                        end,
                        DpAcc,
                        lists:seq(0, MinProfit)
                    )
                end,
                Acc,
                lists:seq(0, N - G)
            )
        end,
        DP1,
        lists:zip(Group, Profit)
    ),
    lists:foldl(
        fun(I, Sum) ->
            lists:foldl(
                fun(J, Acc) ->
                    (Acc + array:get(J, array:get(I, DP1))) rem Mod
                end,
                Sum,
                lists:seq(MinProfit, MinProfit)
            )
        end,
        0,
        lists:seq(0, N)
    ).