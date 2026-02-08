-module(solution).
-export([minimum_time_required/2]).

minimum_time_required(Jobs, K) ->
    N = length(Jobs),
    case N =:= 0 of
        true -> 0;
        false ->
            Max = lists:max(Jobs),
            Sum = lists:sum(Jobs),
            binary_search(Jobs, K, Max, Sum)
    end.

binary_search(Jobs, K, Left, Right) ->
    if
        Left >= Right -> Left;
        true ->
            Mid = (Left + Right) div 2,
            case is_possible(Jobs, K, Mid) of
                true -> binary_search(Jobs, K, Left, Mid);
                false -> binary_search(Jobs, K, Mid + 1, Right)
            end
    end.

is_possible(Jobs, K, Limit) ->
    is_possible(Jobs, K, Limit, 0, 0, 0).

is_possible([], _, _, _, WorkersUsed, _) ->
    WorkersUsed =< 0;
is_possible([Job | Rest], K, Limit, CurrentLoad, WorkersUsed, Index) ->
    if
        CurrentLoad + Job =< Limit ->
            (is_possible(Rest, K, Limit, CurrentLoad + Job, WorkersUsed, Index + 1) orelse
            (WorkersUsed + 1 < K andalso is_possible(Rest, K, Limit, Job, WorkersUsed + 1, Index + 1));
        true ->
            WorkersUsed + 1 < K andalso is_possible(Rest, K, Limit, Job, WorkersUsed + 1, Index + 1)
    end.