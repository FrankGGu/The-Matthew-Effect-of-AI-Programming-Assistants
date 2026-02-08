-module(solution).
-export([max_consecutive/1]).

max_consecutive(Assorted) ->
    max_consecutive(Assorted, 1).

max_consecutive([], _), 1;
max_consecutive([H|T], Acc) when H == Acc ->
    max_consecutive(T, Acc + 1);
max_consecutive(_, Acc) ->
    Acc - 1.