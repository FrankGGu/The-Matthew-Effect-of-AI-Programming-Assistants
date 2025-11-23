-module(foobar).
-export([start/1, foo/1, bar/1]).

start(N) ->
    spawn(fun() -> foo(N) end),
    spawn(fun() -> bar(N) end).

foo(0) ->
    ok;
foo(N) ->
    io:format("foo", []),
    receive
        {bar, Pid} ->
            Pid ! {foo, self()}
    end,
    foo(N - 1).

bar(0) ->
    ok;
bar(N) ->
    receive
        {foo, Pid} ->
            io:format("bar", []),
            Pid ! {bar, self()}
    end,
    bar(N - 1).