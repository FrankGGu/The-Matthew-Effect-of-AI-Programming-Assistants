-module(solution).
-export([mincost_tickets/2]).

mincost_tickets(Days, Costs) ->
    MaxDay = lists:max(Days),
    Duration = MaxDay + 1,
    DP = lists:duplicate(Duration, infinity),
    DP = lists:sublist(DP, 1, 1) ++ [0 | lists:sublist(DP, 2, Duration - 1)],
    DaysSet = sets:from_list(Days),
    lists:foldl(fun(Day, DP) ->
        DP1 = lists:update_element(Day, min(DP1, lists:nth(Day - 1, DP) + hd(Costs)), DP),
        DP2 = lists:update_element(Day, min(DP1, lists:nth(Day - 1, DP) + lists:nth(2, Costs)), DP1),
        lists:update_element(Day, min(DP2, lists:nth(Day - 1, DP) + lists:nth(3, Costs)), DP2)
    end, DP, DaysSet),
    lists:last(DP).