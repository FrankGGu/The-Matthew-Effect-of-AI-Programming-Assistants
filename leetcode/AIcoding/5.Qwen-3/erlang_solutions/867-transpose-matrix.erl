-module(transpose_matrix).
-export([transpose/1]).

transpose(Matrix) ->
    transpose(Matrix, []).

transpose([], Acc) ->
    lists:reverse(Acc);
transpose([Row | Rest], Acc) ->
    transpose(Rest, [lists:zipwith(fun(X, Y) -> {X, Y} end, Row, Acc) | Acc]).