-module(solution).
-export([find_original/1]).

find_original(Rows) ->
    find_original(Rows, []).

find_original([], Acc) ->
    lists:reverse(Acc);
find_original([Row | Rest], Acc) ->
    [Char | _] = Row,
    find_original(Rest, [Char | Acc]).