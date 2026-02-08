-module(solution).
-export([waysToReachTarget/2]).

waysToReachTarget(Types, Target) ->
    MOD = 1000000000 + 7,

    InitialMemo = maps:new(),

    {Ways, _FinalMemo} = solve(0, Target, Types, InitialMemo, MOD),
    Ways.

solve(TypeIndex, CurrentTarget, Types, Memo, MOD) ->
    if CurrentTarget == 0 ->
        {1, Memo};
       CurrentTarget < 0 ->
        {0, Memo};
       TypeIndex >= length(Types) ->
        {0, Memo};
       true ->
        case maps:find({TypeIndex, CurrentTarget}, Memo) of
            {ok, Ways} ->
                {Ways, Memo};
            error ->
                [Count, Points] = lists:nth(TypeIndex + 1, Types),

                {TotalWays, FinalMemoAfterFold} = lists:foldl(
                    fun(K, {AccWays, CurrentMemo}) ->
                        RemainingTarget = CurrentTarget - K * Points,

                        {WaysFromNextType, NewMemoFromRecurse} = solve(TypeIndex + 1, RemainingTarget, Types, CurrentMemo, MOD),

                        {(AccWays + WaysFromNextType) rem MOD, NewMemoFromRecurse}
                    end,
                    {0, Memo},
                    lists:seq(0, Count)
                ),

                FinalMemo = maps:put({TypeIndex, CurrentTarget}, TotalWays, FinalMemoAfterFold),
                {TotalWays, FinalMemo}
        end
    end.