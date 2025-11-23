-module(solution).
-export([can_be_equal/2]).

can_be_equal(Target, Arr) ->
    lists:sort(Target) == lists:sort(Arr).