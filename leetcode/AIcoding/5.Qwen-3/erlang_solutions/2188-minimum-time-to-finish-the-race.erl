-module(minimum_time_to_finish_the_race).
-export([minTimeToFinish/2]).

minTimeToFinish(panels, time) ->
    N = length(panels),
    DP = array:new(N, {default, 0}),
    array:set(0, panels, DP),
    minTimeToFinish(panels, time, 1, DP).

minTimeToFinish(_, _, N, _) when N >= length(panels) -> 
    array:get(length(panels) - 1, arrays:to_list(DP)).

minTimeToFinish(panels, Time, Index, DP) ->
    CurrentPanel = array:get(Index - 1, arrays:to_list(DP)),
    NewValue = CurrentPanel + Time,
    UpdatedDP = array:set(Index, NewValue, DP),
    minTimeToFinish(panels, Time, Index + 1, UpdatedDP).