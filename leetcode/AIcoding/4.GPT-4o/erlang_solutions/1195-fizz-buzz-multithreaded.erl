-module(fizz_buzz).
-export([fizz_buzz/1]).

fizz_buzz(N) ->
    P = spawn(fun() -> fizz(N, 1) end),
    P.

fizz(N, I) when I > N -> ok;
fizz(N, I) ->
    case {I rem 3, I rem 5} of
        {0, 0} -> io:format("FizzBuzz~n"),
        {0, _} -> io:format("Fizz~n"),
        {_, 0} -> io:format("Buzz~n"),
        _ -> io:format("~p~n", [I])
    end,
    fizz(N, I + 1).