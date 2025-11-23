-module(dining_philosophers).
-export([dine/1]).

-record(philosopher, {id, left_fork, right_fork, semaphore}).

dine(N) ->
    Forks = lists:map(fun(_) -> semaphore:new(1) end, lists:seq(1, N)),
    Philosophers = [#philosopher{id = I, left_fork = lists:nth(I, Forks), right_fork = lists:nth((I rem N) + 1, Forks), semaphore = semaphore:new(1)} || I <- lists:seq(1, N)],
    lists:foreach(fun(P) -> spawn(fun() -> philosopher_loop(P) end) end, Philosophers).

philosopher_loop(#philosopher{id = Id, left_fork = LF, right_fork = RF, semaphore = S}) ->
    loop(Id, LF, RF, S).

loop(Id, LF, RF, S) ->
    semaphore:wait(S),
    semaphore:wait(LF),
    semaphore:wait(RF),
    eat(Id),
    semaphore:signal(RF),
    semaphore:signal(LF),
    semaphore:signal(S),
    loop(Id, LF, RF, S).

eat(Id) ->
    io:format("Philosopher ~p is eating~n", [Id]),
    timer:sleep(1000).