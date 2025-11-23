-module(dining_philosophers).
-export([start/1, pickup/2, putdown/2]).

start(N) ->
    Pids = [spawn(fun() -> philosopher(I, N) end) || I <- lists:seq(1, N)],
    [register(list_to_atom("phil" ++ integer_to_list(I)), Pid) || {I,Pid} <- lists:zip(lists:seq(1,N),Pids)],
    [spawn(fun() -> fork(I) end) || I <- lists:seq(1, N)].

philosopher(Id, N) ->
    LeftFork = Id,
    RightFork = (Id rem N) + 1,
    io:format("Philosopher ~w started~n", [Id]),
    loop(Id, LeftFork, RightFork, N).

loop(Id, LeftFork, RightFork, N) ->
    timer:sleep(rand:uniform(1000)), % Thinking
    pickup(Id, LeftFork),
    pickup(Id, RightFork),
    io:format("Philosopher ~w eating~n", [Id]),
    timer:sleep(rand:uniform(1000)), % Eating
    putdown(Id, LeftFork),
    putdown(Id, RightFork),
    loop(Id, LeftFork, RightFork, N).

fork(Id) ->
    register(list_to_atom("fork" ++ integer_to_list(Id)), self()),
    loop2(Id).

loop2(Id) ->
    receive
        {pickup, Pid} ->
            Pid ! {taken, Id},
            receive
                {putdown, Pid2} ->
                    loop2(Id)
            end;
        {putdown, Pid} ->
            loop2(Id)
    end.

pickup(PhilosopherId, ForkId) ->
    Fork = list_to_atom("fork" ++ integer_to_list(ForkId)),
    Philosopher = list_to_atom("phil" ++ integer_to_list(PhilosopherId)),
    Fork ! {pickup, Philosopher},
    receive
        {taken, ForkId} ->
            ok
    end.

putdown(PhilosopherId, ForkId) ->
    Fork = list_to_atom("fork" ++ integer_to_list(ForkId)),
    Philosopher = list_to_atom("phil" ++ integer_to_list(PhilosopherId)),
    Fork ! {putdown, Philosopher}.