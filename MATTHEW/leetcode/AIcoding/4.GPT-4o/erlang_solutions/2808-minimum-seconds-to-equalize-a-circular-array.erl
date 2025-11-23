-module(solution).
-export([minimum_seconds/1]).

minimum_seconds(A) ->
    N = length(A),
    Map = maps:from_list([{Elem, Index} || {Elem, Index} <- lists:zip(A, lists:seq(0, N-1))]),
    MinSeconds = lists:foldl(fun({Elem, Index}, Acc) ->
        TargetIndex = maps:get(Elem, Map),
        Seconds = (TargetIndex - Index + N) rem N,
        min(Acc, Seconds)
    end, N, lists:zip(A, lists:seq(0, N-1))),
    MinSeconds.