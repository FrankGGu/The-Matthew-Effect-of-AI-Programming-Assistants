-module(solution).
-export([find_best_value/2]).

find_best_value(A, target) ->
    Min = lists:min(A),
    Max = lists:max(A),
    find_best_value_helper(Min, Max, A, target).

find_best_value_helper(Low, High, A, Target) when Low >= High ->
    Low;
find_best_value_helper(Low, High, A, Target) ->
    Mid = (Low + High) div 2,
    Sum = lists:sum(lists:map(fun(X) -> if X > Mid -> Mid; true -> X end end, A)),
    case Sum of
        S when S < Target -> find_best_value_helper(Mid + 1, High, A, Target);
        S when S > Target -> find_best_value_helper(Low, Mid, A, Target);
        _ -> Mid
    end.