-module(find_minimum_time).
-export([min_time/2]).

min_time(Jobs, K) ->
    max(Jobs) * (length(Jobs) div K + 1),
    binary_search(1, sum(Jobs), Jobs, K).

binary_search(Low, High, Jobs, K) ->
    if Low >= High ->
        Low;
    true ->
        Mid = (Low + High) div 2,
        if can_finish(Jobs, K, Mid) ->
            binary_search(Low, Mid, Jobs, K);
        true ->
            binary_search(Mid + 1, High, Jobs, K)
        end
    end.

can_finish(Jobs, K, MaxTime) ->
    can_finish(Jobs, K, MaxTime, []).

can_finish([], _K, _MaxTime, _Workers) ->
    true;
can_finish(Jobs, K, MaxTime, Workers) ->
    case find_worker(Workers, Jobs, MaxTime) of
        {ok, NewWorkers, NewJobs} ->
            can_finish(NewJobs, K, MaxTime, NewWorkers);
        error ->
            if length(Workers) < K ->
                [Job | RestJobs] = Jobs,
                can_finish(RestJobs, K, MaxTime, [{Job, Job} | Workers]);
            true ->
                false
            end
    end.

find_worker(Workers, Jobs, MaxTime) ->
    find_worker(Workers, Jobs, MaxTime, []).

find_worker([], Jobs, _MaxTime, Acc) ->
    if length(Acc) > 0 ->
        {ok, lists:reverse(Acc), Jobs};
    true ->
        error
    end;
find_worker([{Time, OriginalTime} | RestWorkers], Jobs, MaxTime, Acc) ->
    case Jobs of
        [Job | RestJobs] ->
            if Time + Job =< MaxTime ->
                find_worker(RestWorkers, RestJobs, MaxTime, [{Time + Job, OriginalTime} | Acc]);
            true ->
                find_worker(RestWorkers, Jobs, MaxTime, Acc)
            end;
        [] ->
            {ok, lists:reverse(Acc) ++ RestWorkers, []}
    end.

sum(List) ->
    sum(List, 0).

sum([], Acc) ->
    Acc;
sum([H | T], Acc) ->
    sum(T, Acc + H).