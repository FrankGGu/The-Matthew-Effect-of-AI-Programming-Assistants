-module(solution).
-export([can_be_equal/2]).

can_be_equal(A, B) ->
    lists:sort(A) == lists:sort(B).