-module(solution).
-export([longest_subsequence_sum/2]).

longest_subsequence_sum(Coins, Target) ->
    InitialDp = array:set(0, 0, array:new([{size, Target + 1}, {default, -1}])),

    FinalDp = lists:foldl(
        fun(Coin, CurrentDp) ->
            lists:foldl(
                fun(J, InnerDp) ->
                    PrevSumLen = array:get(J - Coin, InnerDp),
                    if
                        PrevSumLen =/= -1 ->
                            CurrentLen = array:get(J, InnerDp),
                            NewLen = PrevSumLen + 1,
                            if
                                NewLen > CurrentLen ->
                                    array:set(J, NewLen, InnerDp);
                                true ->
                                    InnerDp
                            end;
                        true ->
                            InnerDp
                    end
                end,
                CurrentDp,
                lists:seq(Target, Coin, -1)
            )
        end,
        InitialDp,
        Coins
    ),

    array:get(Target, FinalDp).