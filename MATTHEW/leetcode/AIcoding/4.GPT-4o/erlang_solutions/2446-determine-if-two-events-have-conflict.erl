-module(solution).
-export([haveConflict/2]).

haveConflict(Event1, Event2) ->
    {Start1, End1} = lists:map(fun(X) -> string:to_integer(X) end, string:split(Event1, "-")),
    {Start2, End2} = lists:map(fun(X) -> string:to_integer(X) end, string:split(Event2, "-")),
    (Start1 <= End2) andalso (Start2 <= End1).