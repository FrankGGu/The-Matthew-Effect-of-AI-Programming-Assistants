-module(solution).
-export([closestValue/3]).

closestValue(Function, Target, K) ->
    find_closest(Function, Target, K, -1.0 / 0.0, 1.0 / 0.0).

find_closest(_, Target, K, Min, Max) when K == 0 ->
    Min;
find_closest(Function, Target, K, Min, Max) ->
    NewMin = min(Min, Function(K)),
    NewMax = max(Max, Function(K)),
    find_closest(Function, Target, K - 1, NewMin, NewMax).