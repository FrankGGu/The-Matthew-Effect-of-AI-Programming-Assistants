-module(solution).
-export([count_routes/3]).

count_routes(Locations, Start, Finish) ->
    N = length(Locations),
    StartLoc = lists:nth(Start + 1, Locations),
    FinishLoc = lists:nth(Finish + 1, Locations),
    Memo = maps:new(),
    {Result, _} = dp(Start, 1, Locations, FinishLoc, Memo),
    Result.

dp(Current, Fuel, Locations, FinishLoc, Memo) ->
    Key = {Current, Fuel},
    case maps:get(Key, Memo, undefined) of
        undefined ->
            N = length(Locations),
            CurrentLoc = lists:nth(Current + 1, Locations),
            Total = if
                CurrentLoc == FinishLoc -> 1;
                true -> 0
            end,
            Sum = lists:foldl(
                fun(Next, Acc) ->
                    if
                        Next == Current -> Acc;
                        true ->
                            NextLoc = lists:nth(Next + 1, Locations),
                            NeededFuel = abs(CurrentLoc - NextLoc),
                            if
                                NeededFuel > Fuel -> Acc;
                                true ->
                                    {Count, NewMemo} = dp(Next, Fuel - NeededFuel, Locations, FinishLoc, Memo),
                                    {Count + Acc, NewMemo}
                            end
                    end
                end,
                {Total, Memo},
                lists:seq(0, N - 1)
            end,
            {SumCount, SumMemo} = Sum,
            NewMemo = maps:put(Key, SumCount, SumMemo),
            {SumCount, NewMemo};
        Cached ->
            {Cached, Memo}
    end.