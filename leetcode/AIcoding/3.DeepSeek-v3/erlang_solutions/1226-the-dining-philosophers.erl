-module(dining_philosophers).
-export([init/1, wants_to_eat/6]).

init(N) ->
    Forks = lists:map(fun(_) -> spawn(fun() -> fork() end) end, lists:seq(1, N)),
    {ok, Forks}.

wants_to_eat(Philosopher, LeftFork, RightFork, Pid, Forks, _) ->
    LeftForkPid = lists:nth(LeftFork + 1, Forks),
    RightForkPid = lists:nth(RightFork + 1, Forks),
    pick_forks(Philosopher, LeftForkPid, RightForkPid),
    Pid ! {Philosopher, eating},
    release_forks(LeftForkPid, RightForkPid),
    Pid ! {Philosopher, finished}.

pick_forks(Philosopher, LeftForkPid, RightForkPid) ->
    case Philosopher rem 2 of
        0 -> 
            RightForkPid ! {self(), take},
            receive ok -> ok end,
            LeftForkPid ! {self(), take},
            receive ok -> ok end;
        1 ->
            LeftForkPid ! {self(), take},
            receive ok -> ok end,
            RightForkPid ! {self(), take},
            receive ok -> ok end
    end.

release_forks(LeftForkPid, RightForkPid) ->
    LeftForkPid ! release,
    RightForkPid ! release.

fork() ->
    receive
        {From, take} ->
            From ! ok,
            receive
                release -> fork()
            end
    end.