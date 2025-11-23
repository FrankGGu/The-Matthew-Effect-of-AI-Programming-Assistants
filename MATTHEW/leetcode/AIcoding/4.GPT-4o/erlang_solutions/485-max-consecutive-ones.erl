-module(solution).
-export([find_max_consecutive_ones/1]).

-spec find_max_consecutive_ones([integer()]) -> integer().
find_max_consecutive_ones(Nums) ->
    find_max_consecutive_ones(Nums, 0, 0).

%% Helper function to track the current consecutive ones and the maximum count
-spec find_max_consecutive_ones([integer()], integer(), integer()) -> integer().
find_max_consecutive_ones([], Max, _) -> Max;
find_max_consecutive_ones([0 | T], Max, Count) -> 
    find_max_consecutive_ones(T, Max, 0);
find_max_consecutive_ones([1 | T], Max, Count) -> 
    find_max_consecutive_ones(T, max(Max, Count + 1), Count + 1).
