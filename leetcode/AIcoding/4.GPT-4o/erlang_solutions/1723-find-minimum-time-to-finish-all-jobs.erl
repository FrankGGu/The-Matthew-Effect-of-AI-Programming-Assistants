-module(solution).
-export([minimum_time/2]).

minimum_time(Jobs, k) ->
    MaxTime = lists:max(Jobs),
    MinTime = lists:sum(Jobs) div k,
    minimum_time_helper(Jobs, MinTime, MaxTime, k).

minimum_time_helper(_, Low, High, 0) when Low < High -> 
    Mid = (Low + High) div 2,
    case can_finish(Jobs, Mid, k) of 
        true -> minimum_time_helper(Jobs, Low, Mid, k);
        false -> minimum_time_helper(Jobs, Mid + 1, High, k)
    end;
minimum_time_helper(Jobs, Low, Low, _) -> Low.

can_finish(_, _, 0) -> true;
can_finish(Jobs, MaxLoad, Workers) ->
    can_finish_helper(Jobs, MaxLoad, Workers, 0).

can_finish_helper([], _, _) -> true;
can_finish_helper(Jobs, MaxLoad, Workers, CurrentLoad) when CurrentLoad > MaxLoad -> false;
can_finish_helper([H | T], MaxLoad, Workers, CurrentLoad) -> 
    case can_finish_helper(T, MaxLoad, Workers, CurrentLoad + H) of 
        true -> true;
        false -> can_finish_helper(T, MaxLoad, Workers - 1, H)
    end.