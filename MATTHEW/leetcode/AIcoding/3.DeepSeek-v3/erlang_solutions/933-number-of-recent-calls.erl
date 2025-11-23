-module(recent_counter).
-export([init/0, ping/2]).

init() ->
    {[]}.

ping(Pid, T) ->
    {Queue} = Pid,
    NewQueue = enqueue(Queue, T),
    {NewQueue1} = trim(NewQueue, T - 3000),
    {NewQueue1, length(NewQueue1)}.

enqueue(Queue, T) ->
    lists:append(Queue, [T]).

trim(Queue, MinT) ->
    {NewQueue} = lists:dropwhile(fun(X) -> X < MinT end, Queue),
    {NewQueue}.