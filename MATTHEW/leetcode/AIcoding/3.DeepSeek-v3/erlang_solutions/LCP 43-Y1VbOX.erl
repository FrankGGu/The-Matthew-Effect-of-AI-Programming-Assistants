-module(solution).
-export([traffic_light/1]).

traffic_light(Time) ->
    case Time rem 4 of
        0 -> "Green";
        1 -> "Yellow";
        2 -> "Red";
        3 -> "Yellow"
    end.