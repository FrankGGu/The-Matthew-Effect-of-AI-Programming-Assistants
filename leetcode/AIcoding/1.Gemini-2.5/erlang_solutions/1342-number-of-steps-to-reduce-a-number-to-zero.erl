-module(solution).
-export([numberOfSteps/1]).

numberOfSteps(0) -> 0;
numberOfSteps(Num) when Num rem 2 == 0 ->
    1 + numberOfSteps(Num div 2);
numberOfSteps(Num) ->
    1 + numberOfSteps(Num - 1).