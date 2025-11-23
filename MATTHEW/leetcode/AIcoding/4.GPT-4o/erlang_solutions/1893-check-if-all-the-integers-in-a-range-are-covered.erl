-module(solution).
-export([isCovered/3]).

isCovered(Ranges, L, R) ->
    lists:all(fun(X) -> lists:any(fun({A, B}) -> A =< X, X =< B end, Ranges) end, lists:seq(L, R)).