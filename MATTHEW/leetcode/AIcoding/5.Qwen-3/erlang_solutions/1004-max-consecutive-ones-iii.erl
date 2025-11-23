-module(max_consecutive_ones_iii).
-export([find_max_consecutive_ones/1]).

find_max_consecutive_ones(Nums) ->
    find_max_consecutive_ones(Nums, 0, 0, 0).

find_max_consecutive_ones([], Left, Right, Max) ->
    Max;
find_max_consecutive_ones([0 | Rest], Left, Right, Max) ->
    find_max_consecutive_ones(Rest, Left + 1, Right + 1, Max);
find_max_consecutive_ones([1 | Rest], Left, Right, Max) ->
    NewRight = Right + 1,
    NewMax = max(Max, NewRight - Left),
    find_max_consecutive_ones(Rest, Left, NewRight, NewMax).