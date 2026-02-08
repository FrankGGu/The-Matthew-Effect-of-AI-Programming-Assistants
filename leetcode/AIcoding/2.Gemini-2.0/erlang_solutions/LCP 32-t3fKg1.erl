-module(batch_tasks).
-export([batch_tasks/2]).

batch_tasks(tasks, n) ->
    batch_tasks(tasks, n, []).

batch_tasks([], _N, Acc) ->
    lists:reverse(Acc);
batch_tasks(Tasks, N, Acc) ->
    {Batch, Rest} = lists:split(N, Tasks),
    Acc1 = [execute_batch(Batch) | Acc],
    batch_tasks(Rest, N, Acc1).

execute_batch(Batch) ->
    lists:sum(Batch).