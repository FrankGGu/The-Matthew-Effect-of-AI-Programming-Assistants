-module(solution).
-export([shuffle_array/2]).

shuffle_array(Nums, N) ->
    Xs = lists:sublist(Nums, N),
    Ys = lists:nthtail(N, Nums),
    interleave(Xs, Ys, []).

interleave([], [], Acc) ->
    lists:reverse(Acc);
interleave([X|Xs], [Y|Ys], Acc) ->
    interleave(Xs, Ys, [Y, X | Acc]).