-module(flower_bloom).
-export([full_bloom_flowers/2]).

full_bloom_flowers(Events, Persons) ->
    Start = lists:sort([S || {S, _} <- Events]),
    End = lists:sort([E || {_, E} <- Events]),
    lists:map(fun(P) -> count_blooming(Start, End, P) end, Persons).

count_blooming(Start, End, P) ->
    L = length([X || X <- Start, X =< P]),
    R = length([Y || Y <- End, Y < P]),
    L - R.