-module(solution).
-export([can_circular_route/1]).

can_circular_route(Gas) ->
    can_circular_route(Gas, 0, 0, 0, 0).

can_circular_route([], TotalGas, TotalCost, _, Start) when TotalGas >= TotalCost ->
    Start;
can_circular_route([], _, _, _, _) ->
    -1;
can_circular_route([{G, C} | Rest], TotalGas, TotalCost, CurrentGas, Start) ->
    NewTotalGas = TotalGas + G,
    NewTotalCost = TotalCost + C,
    NewCurrentGas = CurrentGas + G - C,
    if
        NewCurrentGas >= 0 ->
            can_circular_route(Rest, NewTotalGas, NewTotalCost, NewCurrentGas, Start);
        true ->
            can_circular_route(Rest, NewTotalGas, NewTotalCost, 0, Start + 1)
    end.