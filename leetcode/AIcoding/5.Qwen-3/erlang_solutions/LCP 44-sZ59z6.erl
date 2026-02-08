-module(solution).
-export([fireworks/1]).

fireworks(Height) ->
    N = Height,
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> io:format("~p ", [J]) end, lists:seq(1, I)),
        io:format("~n")
    end, lists:seq(1, N)).