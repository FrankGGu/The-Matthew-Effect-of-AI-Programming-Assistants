-module(fizz_buzz).
-export([start/1, fizz/2, buzz/2, fizzbuzz/2, number/2]).

start(N) ->
    Pid = spawn(fun() -> init(N) end),
    register(fizz_buzz_server, Pid).

init(N) ->
    Fizz = spawn(?MODULE, fizz, [self(), N]),
    Buzz = spawn(?MODULE, buzz, [self(), N]),
    FizzBuzz = spawn(?MODULE, fizzbuzz, [self(), N]),
    Number = spawn(?MODULE, number, [self(), N]),
    loop(Fizz, Buzz, FizzBuzz, Number, 1, N).

loop(Fizz, Buzz, FizzBuzz, Number, I, N) when I > N ->
    Fizz ! stop,
    Buzz ! stop,
    FizzBuzz ! stop,
    Number ! stop,
    ok;
loop(Fizz, Buzz, FizzBuzz, Number, I, N) ->
    receive
        {fizz, Pid} when I rem 3 == 0, I rem 5 /= 0 ->
            Pid ! {print, fizz},
            loop(Fizz, Buzz, FizzBuzz, Number, I + 1, N);
        {buzz, Pid} when I rem 5 == 0, I rem 3 /= 0 ->
            Pid ! {print, buzz},
            loop(Fizz, Buzz, FizzBuzz, Number, I + 1, N);
        {fizzbuzz, Pid} when I rem 15 == 0 ->
            Pid ! {print, fizzbuzz},
            loop(Fizz, Buzz, FizzBuzz, Number, I + 1, N);
        {number, Pid} when I rem 3 /= 0, I rem 5 /= 0 ->
            Pid ! {print, I},
            loop(Fizz, Buzz, FizzBuzz, Number, I + 1, N);
        _ ->
            loop(Fizz, Buzz, FizzBuzz, Number, I, N)
    end.

fizz(Parent, N) ->
    receive
        stop ->
            ok;
        _ ->
            Parent ! {fizz, self()},
            fizz(Parent, N)
    end.

buzz(Parent, N) ->
    receive
        stop ->
            ok;
        _ ->
            Parent ! {buzz, self()},
            buzz(Parent, N)
    end.

fizzbuzz(Parent, N) ->
    receive
        stop ->
            ok;
        _ ->
            Parent ! {fizzbuzz, self()},
            fizzbuzz(Parent, N)
    end.

number(Parent, N) ->
    receive
        stop ->
            ok;
        _ ->
            Parent ! {number, self()},
            number(Parent, N)
    end.