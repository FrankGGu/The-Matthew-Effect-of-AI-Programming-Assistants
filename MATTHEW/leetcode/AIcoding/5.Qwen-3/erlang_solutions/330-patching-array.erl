-module(patching_array).
-export([min_patches/2]).

min_patches(Arr, N) ->
    min_patches(Arr, N, 0, 0).

min_patches([], _, _, Acc) ->
    Acc;
min_patches([H | T], N, Current, Acc) when H =< N ->
    min_patches(T, N, Current + H, Acc);
min_patches([H | T], N, Current, Acc) ->
    min_patches([H | T], N, Current, Acc + 1);
min_patches(_, N, Current, Acc) when Current >= N ->
    Acc;
min_patches(_, N, Current, Acc) ->
    min_patches([], N, Current + 1, Acc + 1).