-module(solution).
-export([min_cost_tickets/2]).

min_cost_tickets(Days, Costs) ->
    TravelDays = sets:from_list(Days),
    MaxDay = lists:last(Days),

    % Helper function to get DP value, handling out-of-bounds for negative days.
    get_dp_val(DPMap, Day) when Day < 0 -> 0;
    get_dp_val(DPMap, Day) -> maps:get(Day, DPMap).

    maps:get(MaxDay,
        lists:foldl(
            fun(Day, DPMap) ->
                IfTravelDay = sets:is_element(Day, TravelDays),
                PrevCost = get_dp_val(DPMap, Day - 1),

                NewCost =
                    if
                        IfTravelDay ->
                            % Option 1: 1-day pass
                            Cost1Day = PrevCost + hd(Costs),
                            % Option 2: 7-day pass
                            Cost7Day = get_dp_val(DPMap, Day - 7) + lists:nth(2, Costs),
                            % Option 3: 30-day pass
                            Cost30Day = get_dp_val(DPMap, Day - 30) + lists:nth(3, Costs),
                            min(min(Cost1Day, Cost7Day), Cost30Day);
                        true ->
                            PrevCost
                    end,
                maps:put(Day, NewCost, DPMap)
            end,
            #{0 => 0}, % Initial DP map: cost for day 0 is 0
            lists:seq(1, MaxDay)
        )
    ).