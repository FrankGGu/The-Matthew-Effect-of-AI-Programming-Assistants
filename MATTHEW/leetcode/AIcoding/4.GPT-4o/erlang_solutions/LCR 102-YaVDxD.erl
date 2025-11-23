-module(solution).
-export([find_target_sum_ways/2]).

find_target_sum_ways(Numbers, Target) ->
    find_ways(Numbers, Target, 0).

find_ways([], Target, Sum) when Sum =:= Target -> 1;
find_ways([], _, _) -> 0;
find_ways([H | T], Target, Sum) ->
    find_ways(T, Target, Sum + H) + find_ways(T, Target, Sum - H).