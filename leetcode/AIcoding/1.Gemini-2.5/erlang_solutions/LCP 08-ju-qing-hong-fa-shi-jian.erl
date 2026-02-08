-module(solution).
-export([getTriggerTimes/3]).

getTriggerTimes(InitialResources, Growth, PlotRequirements) ->
    lists:map(fun(PlotReq) ->
        calculate_trigger_time(InitialResources, Growth, PlotReq)
    end, PlotRequirements).

calculate_trigger_time(InitialResources, Growth, PlotReq) ->
    TriggerTimesPerResource = lists:zipwith(fun(InitialR, G, ReqR) ->
        Needed = ReqR - InitialR,
        if
            Needed =< 0 ->
                0;
            G == 0 ->
                infinity;
            true ->
                (Needed + G - 1) div G
        end
    end, InitialResources, Growth, PlotReq),

    case lists:member(infinity, TriggerTimesPerResource) of
        true ->
            -1;
        false ->
            lists:max(TriggerTimesPerResource)
    end.