-module(solution).
-export([find_original/1]).

find_original(Encoded) ->
    find_original(Encoded, []).

find_original([], Acc) ->
    lists:reverse(Acc);
find_original([H | T], Acc) ->
    find_original(T, [H | Acc]).