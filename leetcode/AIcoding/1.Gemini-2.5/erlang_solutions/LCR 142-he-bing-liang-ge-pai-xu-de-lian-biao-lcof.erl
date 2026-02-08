-module(solution).
-export([max_subarray/1]).

max_subarray([]) -> 0;
max_subarray([H|T]) ->
    max_subarray_iter(T, H, H).

max_subarray_iter([], _CurrentMaxEndingHere, GlobalMax) ->
    GlobalMax;
max_subarray_iter([H|T], CurrentMaxEndingHere, GlobalMax) ->
    NewCurrentMaxEndingHere = max(H, CurrentMaxEndingHere + H),
    NewGlobalMax = max(GlobalMax, NewCurrentMaxEndingHere),
    max_subarray_iter(T, NewCurrentMaxEndingHere, NewGlobalMax).