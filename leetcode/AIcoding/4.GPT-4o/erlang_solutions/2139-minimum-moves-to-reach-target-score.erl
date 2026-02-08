-module(solution).
-export([minMoves/2]).

minMoves(Target, MaxStep) ->
    MinMoves = (Target + MaxStep - 1) div MaxStep,
    MinMoves.