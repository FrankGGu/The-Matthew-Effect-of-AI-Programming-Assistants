-module(solution).
-export([find_sequences/2]).

find_sequences(Screen, Target) ->
    lists:filter(fun(X) -> lists:member(X, Screen) end, Target).