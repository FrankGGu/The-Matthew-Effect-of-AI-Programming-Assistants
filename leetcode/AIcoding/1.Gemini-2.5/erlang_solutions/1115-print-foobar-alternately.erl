-module(foobar_alternately).
-export([start/1, foo/2, bar/2]).

foobar_server_loop(0, _CurrentTurn, [], []) ->
    ok;
foobar_server_loop(N, foo, FooWaiters, BarWaiters) ->
    case FooWaiters of
        [Pid | RestFooWaiters] ->
            Pid ! go,
            foobar_server_loop(N, bar, RestFooWaiters, BarWaiters);
        [] ->
            receive
                {request_foo, Pid} ->
                    Pid ! go,
                    foobar_server_loop(N, bar, [], BarWaiters);
                {request_bar, Pid} ->
                    foobar_server_loop(N, foo, FooWaiters, [Pid | BarWaiters])
            end
    end;
foobar_server_loop(N, bar, FooWaiters, BarWaiters) ->
    case BarWaiters of
        [Pid | RestBarWaiters] ->
            Pid ! go,
            foobar_server_loop(N - 1, foo, FooWaiters, RestBarWaiters);
        [] ->
            receive
                {request_bar, Pid} ->
                    Pid ! go,
                    foobar_server_loop(N - 1, foo, FooWaiters, []);
                {request_foo, Pid} ->
                    foobar_server_loop(N, bar, [Pid | FooWaiters], BarWaiters)
            end
    end.

start(N) ->
    spawn(fun() -> foobar_server_loop(N, foo, [], []) end).

foo(ServerPid, PrintFooFun) ->
    ServerPid ! {request_foo, self()},
    receive
        go -> PrintFooFun()
    end.

bar(ServerPid, PrintBarFun) ->
    ServerPid ! {request_bar, self()},
    receive
        go -> PrintBarFun()
    end.