-module(solution).
-export([min_time/2]).

min_time(T, K) ->
    lists:foldl(fun(X, Acc) -> X + Acc end, 0, T) - solve(T, K).

solve(T, K) ->
    Len = length(T),
    solve_helper(T, K, Len, 0, lists:max(T), lists:foldl(fun(X, Acc) -> X + Acc end, 0, T)).

solve_helper(T, K, Len, Low, High, Sum) ->
    if Low =:= High ->
        Low
    else
        Mid = (Low + High) div 2,
        if check(T, K, Len, Mid) ->
            solve_helper(T, K, Len, Low, Mid, Sum)
        else
            solve_helper(T, K, Len, Mid + 1, High, Sum)
    end.

check(T, K, Len, Max) ->
    count_groups(T, Len, Max, 1, 0).

count_groups(T, Len, Max, Count, Current) ->
    count_groups_helper(T, Len, Max, Count, Current, 0).

count_groups_helper(_, _, _, Count, _, Index) when Index >= Len ->
    Count =< K;
count_groups_helper(T, Len, Max, Count, Current, Index) ->
    if Current + lists:nth(Index + 1, T) > Max ->
        count_groups_helper(T, Len, Max, Count + 1, lists:nth(Index + 1, T), Index + 1)
    else
        count_groups_helper(T, Len, Max, Count, Current + lists:nth(Index + 1, T), Index + 1)
    end.