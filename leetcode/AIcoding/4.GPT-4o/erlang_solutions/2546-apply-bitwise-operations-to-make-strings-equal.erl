-module(solution).
-export([makeEqual/2]).

makeEqual(A, B) ->
    lists:all(fun(X) -> lists:member(X, A) orelse lists:member(X, B) end, lists:seq(97, 122)).