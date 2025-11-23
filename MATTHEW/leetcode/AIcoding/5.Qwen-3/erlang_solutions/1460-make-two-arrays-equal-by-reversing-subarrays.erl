-module(solution).
-export([canBeEqual/2]).

canBeEqual(Target, A) ->
    canBeEqual(sorted(Target), sorted(A)).

sorted(List) ->
    lists:sort(List).