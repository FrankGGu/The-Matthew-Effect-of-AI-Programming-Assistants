-module(solution).
-export([rob/1]).

rob(Nums) ->
    rob_helper(Nums, 0, 0).

rob_helper([], _RobPrev, RobCurrent) ->
    RobCurrent;
rob_helper([H | T], RobPrev, RobCurrent) ->
    NewRobCurrent = max(RobPrev + H, RobCurrent),
    rob_helper(T, RobCurrent, NewRobCurrent).