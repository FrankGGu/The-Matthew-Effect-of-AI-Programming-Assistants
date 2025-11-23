-module(solution).
-export([rob/1]).

rob(Nums) ->
    rob_acc(Nums, 0, 0).

rob_acc([], _RobBeforePrev, CurrentMax) ->
    CurrentMax;
rob_acc([H|T], RobBeforePrev, CurrentMax) ->
    NewCurrentMax = max(CurrentMax, RobBeforePrev + H),
    rob_acc(T, CurrentMax, NewCurrentMax).