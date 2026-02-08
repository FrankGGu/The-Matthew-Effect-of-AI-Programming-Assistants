-module(job_scheduling).
-export([max_profit/1]).

max_profit(Jobs) ->
    Sorted = lists:sort(fun({S1, E1, P1}, {S2, E2, P2}) -> S1 < S2 end, Jobs),
    Sizes = lists:seq(0, length(Sorted) - 1),
    Profit = lists:map(fun({_S, _E, P}) -> P end, Sorted),
    Start = lists:map(fun({S, _E, _P}) -> S end, Sorted),
    End = lists:map(fun({_S, E, _P}) -> E end, Sorted),
    DP = array:new(length(Sorted), {default, 0}),
    max_profit_helper(Sorted, Start, End, Profit, DP, 0).

max_profit_helper(_, _, _, _, DP, Index) when Index >= length(DP) ->
    array:get(length(DP) - 1, DP);

max_profit_helper(Sorted, Start, End, Profit, DP, Index) ->
    CurrentProfit = Profit[Index],
    NextIndex = find_next_job(Index, Start, End),
    if
        NextIndex == -1 ->
            NewProfit = CurrentProfit;
        true ->
            NewProfit = CurrentProfit + array:get(NextIndex, DP)
    end,
    MaxProfit = max(NewProfit, array:get(Index, DP)),
    DP1 = array:set(Index, MaxProfit, DP),
    max_profit_helper(Sorted, Start, End, Profit, DP1, Index + 1).

find_next_job(Index, Start, End) ->
    Target = lists:nth(Index + 1, End),
    find_next_job_helper(Start, End, Index, Target, 0, length(Start) - 1).

find_next_job_helper(_, _, _, _, L, R) when L > R ->
    -1;

find_next_job_helper(Start, End, Index, Target, L, R) ->
    Mid = (L + R) div 2,
    if
        lists:nth(Mid + 1, Start) >= Target ->
            case Mid of
                Index -> find_next_job_helper(Start, End, Index, Target, L, Mid - 1);
                _ -> find_next_job_helper(Start, End, Index, Target, L, Mid - 1)
            end;
        true ->
            find_next_job_helper(Start, End, Index, Target, Mid + 1, R)
    end.