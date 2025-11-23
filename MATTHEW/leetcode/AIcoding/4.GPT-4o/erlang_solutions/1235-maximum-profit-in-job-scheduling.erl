-module(solution).
-export([job_scheduling/2]).

job_scheduling(Jobs, Values) ->
    JobsWithValues = lists:zip(Jobs, Values),
    SortedJobs = lists:sort(fun({A, _}, {B, _}) -> A < B end, JobsWithValues),
    schedule(SortedJobs, []).

schedule([], Acc) ->
    lists:sum(Acc);
schedule([{End, Value} | Tail], Acc) ->
    NewAcc = [Value + schedule(choose_next(End, Tail), Acc)],
    lists:max(NewAcc).

choose_next(End, []) ->
    [];
choose_next(End, [{Start, _} | Tail]) when Start > End ->
    [{Start, _} | choose_next(End, Tail)];
choose_next(End, [_ | Tail]) ->
    choose_next(End, Tail).