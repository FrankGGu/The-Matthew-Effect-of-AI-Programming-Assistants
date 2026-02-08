-module(dining_philosophers).
-export([philosopher/2]).

philosopher(Id, LeftFork) ->
    RightFork = (Id + 1) rem 5,
    take_forks(Id, LeftFork, RightFork).

take_forks(Id, Left, Right) ->
    receive
        {take, From} when From == Id ->
            case get_fork(Left) of
                ok ->
                    case get_fork(Right) of
                        ok ->
                            eat(Id),
                            drop_fork(Left),
                            drop_fork(Right),
                            take_forks(Id, Left, Right);
                        _ ->
                            release_fork(Left),
                            take_forks(Id, Left, Right)
                    end;
                _ ->
                    release_fork(Right),
                    take_forks(Id, Left, Right)
            end
    end.

get_fork(Fork) ->
    erlang:send(Fork, {take, self()}),
    receive
        {ok, Fork} -> ok;
        {error, Fork} -> error
    after 1000 ->
        error
    end.

release_fork(Fork) ->
    erlang:send(Fork, {release, self()}).

drop_fork(Fork) ->
    erlang:send(Fork, {drop, self()}).

eat(Id) ->
    erlang:display({Id, "eating"}).

fork(Pid) ->
    spawn(fun() -> fork_loop(Pid) end).

fork_loop(Pid) ->
    receive
        {take, From} ->
            Pid ! {ok, self()},
            fork_loop(From);
        {release, From} ->
            Pid ! {ok, self()},
            fork_loop(From);
        {drop, From} ->
            Pid ! {ok, self()},
            fork_loop(From)
    end.