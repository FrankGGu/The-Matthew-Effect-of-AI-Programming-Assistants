-module(solution).
-export([remove_sticks/1]).

remove_sticks(Sticks) ->
    lists:sort(lists:reverse(lists:map(fun(X) -> X rem 2 end, Sticks))).

remove_sticks(_Args) ->
    [].

remove_sticks() ->
    [].