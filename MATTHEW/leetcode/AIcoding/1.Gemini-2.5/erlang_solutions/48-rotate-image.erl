-module(solution).
-export([rotate/1]).

rotate(Matrix) ->
    Transposed = transpose(Matrix),
    lists:map(fun lists:reverse/1, Transposed).

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose(Matrix) ->
    [ [H || [H|_] <- Matrix] | transpose([T || [_|T] <- Matrix]) ].