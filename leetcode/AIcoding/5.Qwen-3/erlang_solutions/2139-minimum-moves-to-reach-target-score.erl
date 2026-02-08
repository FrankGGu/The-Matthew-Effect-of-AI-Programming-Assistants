-module(minimum_moves_to_reach_target_score).
-export([minMovesToReachTarget/1]).

minMovesToReachTarget(S) ->
    minMovesToReachTarget(S, 0, 0).

minMovesToReachTarget(S, Current, Moves) when Current >= S ->
    Moves;
minMovesToReachTarget(S, Current, Moves) ->
    Next = Current + 1,
    minMovesToReachTarget(S, Next, Moves + 1).