-module(mechanical_accumulator).
-export([start/0, acc/2, get/1, stop/1]).

start() ->
    spawn(fun() -> loop(0) end).

acc(Pid, Value) ->
    Pid ! {acc, Value}.

get(Pid) ->
    Pid ! {get, self()},
    receive
        {Pid, Value} ->
            Value
    end.

stop(Pid) ->
    Pid ! stop.

loop(Accumulator) ->
    receive
        {acc, Value} ->
            loop(Accumulator + Value);
        {get, Pid} ->
            Pid ! {self(), Accumulator},
            loop(Accumulator);
        stop ->
            ok
    end.