-module(solution).
-export([getMinDistance/3]).

getMinDistance(Nums, Target, Start) ->
    getMinDistance_recursive(Nums, Target, Start, 0, infinity).

getMinDistance_recursive([], _Target, _Start, _CurrentIdx, MinDist) ->
    MinDist;
getMinDistance_recursive([H|T], Target, Start, CurrentIdx, AccMinDist) ->
    NewMinDist = 
        if
            H == Target ->
                abs(CurrentIdx - Start);
            true ->
                AccMinDist
        end,
    getMinDistance_recursive(T, Target, Start, CurrentIdx + 1, min(AccMinDist, NewMinDist)).