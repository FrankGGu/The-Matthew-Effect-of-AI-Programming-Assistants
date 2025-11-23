-module(max_events).
-export([maxValue/3]).

maxValue(Events, K) ->
    SortedEvents = lists:sort(fun([S1, _E1, _V1], [S2, _E2, _V2]) -> S1 =< S2 end, Events),
    DP = maps:new(),
    solve(SortedEvents, K, 1, DP).

solve([], _K, _Day, _DP) -> 0;
solve(_Events, 0, _Day, _DP) -> 0;
solve(Events, K, Day, DP) ->
    case maps:find({Day, K}, DP) of
        {ok, Val} -> Val;
        error ->
            {Take, NotTake} = case Events of
                [[S, E, V] | Rest] when S >= Day ->
                    NextDay = E + 1,
                    TakeVal = V + solve(Rest, K - 1, NextDay, DP),
                    NotTakeVal = solve(Rest, K, Day, DP),
                    {TakeVal, NotTakeVal};
                [_ | Rest] ->
                    {0, solve(Rest, K, Day, DP)};
                [] ->
                    {0, 0}
            end,
            MaxVal = max(Take, NotTake),
            NewDP = maps:put({Day, K}, MaxVal, DP),
            MaxVal
    end.