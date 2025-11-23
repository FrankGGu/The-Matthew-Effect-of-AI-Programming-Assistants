-module(solution).
-export([minimum_time_to_finish_all_jobs/2]).

minimum_time_to_finish_all_jobs(Jobs, Workers) ->
    N = length(Jobs),
    M = Workers,
    Min = lists:min(Jobs),
    Max = lists:max(Jobs),
    solve(Jobs, M, 0, Min, Max).

solve(_, 1, _, _, Max) ->
    Max;
solve(Jobs, M, Start, Low, High) ->
    Mid = (Low + High) // 2,
    case can_assign(Jobs, M, Mid) of
        true ->
            solve(Jobs, M, Start, Low, Mid);
        false ->
            solve(Jobs, M, Start, Mid + 1, High)
    end.

can_assign([], _M, _Limit) ->
    true;
can_assign([Job | Jobs], M, Limit) ->
    if
        Job > Limit ->
            false;
        true ->
            can_assign(Jobs, M - 1, Limit) andalso can_assign(Jobs, M, Limit)
    end.