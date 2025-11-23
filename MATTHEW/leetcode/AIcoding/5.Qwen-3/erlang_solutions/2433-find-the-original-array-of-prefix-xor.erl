-module(solution).
-export([find_original/1]).

find_original(Prefix) ->
    N = length(Prefix),
    Original = lists:seq(1, N),
    Original = find_original(Prefix, 0, []),
    Original.

find_original([], _, Acc) ->
    lists:reverse(Acc);
find_original([H | T], Prev, Acc) ->
    Current = H bxor Prev,
    find_original(T, H, [Current | Acc]).