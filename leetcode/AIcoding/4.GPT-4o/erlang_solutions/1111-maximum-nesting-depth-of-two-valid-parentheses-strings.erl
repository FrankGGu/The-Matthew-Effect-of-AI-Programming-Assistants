-module(solution).
-export([max_depth/2]).

max_depth(S1, S2) ->
    Depth1 = max_nesting_depth(S1, 0, 0),
    Depth2 = max_nesting_depth(S2, 0, 0),
    {Depth1, Depth2}.

max_nesting_depth([], CurrentMax, Max) ->
    max(CurrentMax, Max);
max_nesting_depth([H | T], CurrentMax, Max) when H =:= $\( ->
    max_nesting_depth(T, CurrentMax + 1, max(CurrentMax + 1, Max));
max_nesting_depth([H | T], CurrentMax, Max) when H =:= $\) ->
    max_nesting_depth(T, CurrentMax - 1, Max);
max_nesting_depth([_ | T], CurrentMax, Max) ->
    max_nesting_depth(T, CurrentMax, Max).