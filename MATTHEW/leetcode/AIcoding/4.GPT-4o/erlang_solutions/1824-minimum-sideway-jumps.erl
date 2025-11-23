-module(solution).
-export([min_side_jumps/1]).

min_side_jumps(Lane) ->
    min_side_jumps(Lane, 0, 1).

min_side_jumps(Lane, 0, LaneIndex) when LaneIndex > 3 ->
    0;
min_side_jumps(Lane, Jumps, LaneIndex) ->
    case lists:nth(LaneIndex + 1, Lane) of
        0 ->
            min_side_jumps(Lane, Jumps, LaneIndex + 1);
        _ ->
            case lists:nth(LaneIndex + 2, Lane) of
                0 ->
                    min_side_jumps(Lane, Jumps + 1, LaneIndex + 2);
                _ ->
                    min_side_jumps(Lane, Jumps + 1, LaneIndex + 1)
            end
    end.