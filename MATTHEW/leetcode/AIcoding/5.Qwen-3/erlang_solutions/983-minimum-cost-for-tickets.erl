-module(minimum_cost_for_tickets).
-export([solve/1]).

solve(TravelDays) ->
    solve(TravelDays, 0, 0, 0, 0).

solve([], _, _, _, Cost) ->
    Cost;
solve([Day | Rest], DayCount, Day7, Day30, Cost) ->
    NewCost = case DayCount of
        0 -> Cost + 25;
        _ -> Cost
    end,
    NewCost2 = case Day7 of
        0 -> NewCost + 25;
        _ -> NewCost
    end,
    NewCost3 = case Day30 of
        0 -> NewCost2 + 25;
        _ -> NewCost2
    end,
    solve(Rest, DayCount - 1, Day7 - 1, Day30 - 1, NewCost3).