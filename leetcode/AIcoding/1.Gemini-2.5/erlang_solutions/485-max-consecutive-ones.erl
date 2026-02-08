-module(solution).
-export([find_max_consecutive_ones/1]).

find_max_consecutive_ones(Nums) ->
    find_max_consecutive_ones_helper(Nums, 0, 0).

find_max_consecutive_ones_helper([], MaxSoFar, CurrentMax) ->
    max(MaxSoFar, CurrentMax);
find_max_consecutive_ones_helper([1 | T], MaxSoFar, CurrentMax) ->
    find_max_consecutive_ones_helper(T, MaxSoFar, CurrentMax + 1);
find_max_consecutive_ones_helper([0 | T], MaxSoFar, CurrentMax) ->
    NewMaxSoFar = max(MaxSoFar, CurrentMax),
    find_max_consecutive_ones_helper(T, NewMaxSoFar, 0).