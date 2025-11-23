-module(solution).
-export([mySqrt/1]).

mySqrt(X) ->
    case X of
        0 -> 0;
        1 -> 1;
        _ -> binary_search(1, X, 0, X)
    end.

binary_search(Low, High, CurrentBestAns, TargetX) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    MidSquared = Mid * Mid,
    if MidSquared == TargetX ->
           Mid;
       MidSquared < TargetX ->
           binary_search(Mid + 1, High, Mid, TargetX);
       MidSquared > TargetX ->
           binary_search(Low, Mid - 1, CurrentBestAns, TargetX)
    end;
binary_search(_Low, _High, CurrentBestAns, _TargetX) ->
    CurrentBestAns.