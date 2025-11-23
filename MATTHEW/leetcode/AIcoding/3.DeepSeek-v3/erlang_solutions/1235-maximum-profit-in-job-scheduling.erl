-module(max_profit_jobs).
-export([jobScheduling/3]).

jobScheduling(StartTime, EndTime, Profit) ->
    Jobs = lists:zip3(StartTime, EndTime, Profit),
    SortedJobs = lists:sort(fun({S1, _, _}, {S2, _, _}) -> S1 =< S2 end, Jobs),
    DP = array:new([{size, length(SortedJobs)}, {default, 0}]),
    {_, MaxProfit} = schedule_jobs(SortedJobs, DP, 0),
    MaxProfit.

schedule_jobs([], DP, _) -> {DP, 0};
schedule_jobs([{S, E, P} | Rest], DP, Index) ->
    {DP1, MaxProfitWithout} = schedule_jobs(Rest, DP, Index + 1),
    PrevJobIndex = find_last_non_conflicting(SortedJobs, Index),
    ProfitWith = P + case PrevJobIndex of
                        -1 -> 0;
                        I -> array:get(I, DP1)
                     end,
    MaxProfit = max(ProfitWith, MaxProfitWithout),
    DP2 = array:set(Index, MaxProfit, DP1),
    {DP2, MaxProfit}.

find_last_non_conflicting(Jobs, Index) ->
    {S, E, _} = lists:nth(Index + 1, Jobs),
    find_last_non_conflicting(Jobs, Index - 1, S).

find_last_non_conflicting(_, -1, _) -> -1;
find_last_non_conflicting(Jobs, Index, S) ->
    {_, PrevE, _} = lists:nth(Index + 1, Jobs),
    case PrevE =< S of
        true -> Index;
        false -> find_last_non_conflicting(Jobs, Index - 1, S)
    end.