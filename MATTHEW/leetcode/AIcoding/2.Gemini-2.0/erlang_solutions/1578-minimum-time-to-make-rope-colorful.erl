-module(minimum_time_to_make_rope_colorful).
-export([min_cost_to_make_rope_colorful/2]).

min_cost_to_make_rope_colorful(Colors, NeededTime) ->
    min_cost_to_make_rope_colorful(Colors, NeededTime, 0, 0, []).

min_cost_to_make_rope_colorful([], [], Cost, _, _) ->
    Cost;
min_cost_to_make_rope_colorful([Color | RestColors], [Time | RestTimes], Cost, PrevColor, TimeList) ->
    case Color == PrevColor of
        true ->
            case Time > lists:max(TimeList) of
                true ->
                    min_cost_to_make_rope_colorful(RestColors, RestTimes, Cost + lists:min(TimeList), Color, [Time]);
                false ->
                    min_cost_to_make_rope_colorful(RestColors, RestTimes, Cost + Time, Color, TimeList)
            end;
        false ->
            min_cost_to_make_rope_colorful(RestColors, RestTimes, Cost, Color, [Time])
    end.