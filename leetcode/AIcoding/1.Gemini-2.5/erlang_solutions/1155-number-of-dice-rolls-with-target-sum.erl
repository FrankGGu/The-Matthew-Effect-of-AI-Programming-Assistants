-module(solution).
-export([numRollsToTarget/3]).

numRollsToTarget(N, F, Target) ->
    Mod = 1000000007,

    PrevRowDict = dict:new(),
    InitialPrevRowDict = dict:store(0, 1, PrevRowDict),

    FinalRowDict = lists:foldl(
        fun(_I, CurrentPrevRowDict) ->
            NewRowDict = dict:new(),

            lists:foldl(
                fun(J, AccNewRowDict) ->
                    WaysForJ = lists:foldl(
                        fun(K, SumWays) ->
                            PrevJ = J - K,
                            if PrevJ >= 0 ->
                                case dict:find(PrevJ, CurrentPrevRowDict) of
                                    {ok, PrevWays} ->
                                        (SumWays + PrevWays) rem Mod;
                                    _ ->
                                        SumWays
                                end;
                            true ->
                                SumWays
                            end
                        end,
                        0,
                        lists:seq(1, F)
                    ),
                    if WaysForJ > 0 ->
                        dict:store(J, WaysForJ, AccNewRowDict);
                    true ->
                        AccNewRowDict
                    end
                end,
                NewRowDict,
                lists:seq(0, Target)
            )
        end,
        InitialPrevRowDict,
        lists:seq(1, N)
    ),

    case dict:find(Target, FinalRowDict) of
        {ok, Result} -> Result;
        _ -> 0
    end.