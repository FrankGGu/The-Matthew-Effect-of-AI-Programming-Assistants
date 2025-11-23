-module(solution).
-export([find_min/1]).

find_min([H|T]) ->
    find_min(H, T).

find_min(Current, []) ->
    Current;
find_min(Current, [H|T]) when H < Current ->
    find_min(H, T);
find_min(Current, [H|T]) ->
    find_min(Current, T).