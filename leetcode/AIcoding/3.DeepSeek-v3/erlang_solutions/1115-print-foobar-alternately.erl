-module(foobar).
-export([start/2, foo/1, bar/1]).

start(N, Pid) ->
    spawn(?MODULE, foo, [N]),
    spawn(?MODULE, bar, [N]),
    Pid ! started.

foo(0) -> ok;
foo(N) ->
    receive
        foo ->
            io:format("Foo"),
            bar ! bar,
            foo(N - 1)
    end.

bar(0) -> ok;
bar(N) ->
    receive
        bar ->
            io:format("Bar"),
            foo ! foo,
            bar(N - 1)
    end.