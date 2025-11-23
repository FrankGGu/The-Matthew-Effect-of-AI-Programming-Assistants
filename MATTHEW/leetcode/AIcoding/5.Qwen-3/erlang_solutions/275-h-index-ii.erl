-module(h_index_ii).
-export([h_index/1]).

h_index(Citations) ->
    h_index(Citations, 0, length(Citations)).

h_index(_, H, 0) ->
    H;
h_index(Citations, H, N) ->
    Case = lists:nth(N, Citations),
    if
        Case >= N ->
            h_index(Citations, N, N - 1);
        true ->
            h_index(Citations, H, N - 1)
    end.