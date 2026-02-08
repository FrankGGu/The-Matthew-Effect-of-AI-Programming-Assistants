-module(solution).
-export([lus_length/2]).

lus_length(A, B) ->
    if
        A == B ->
            -1;
        true ->
            max(length(A), length(B))
    end.