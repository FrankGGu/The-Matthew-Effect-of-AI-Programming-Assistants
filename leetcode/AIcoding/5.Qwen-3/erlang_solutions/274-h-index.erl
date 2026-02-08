-module(h_index).
-export([h_index/1]).

h_index(Citations) ->
    h_index(Citations, 0, length(Citations)).

h_index([], _H, _N) ->
    0;
h_index([Citation | Rest], H, N) when Citation >= N - H ->
    H + 1;
h_index([_ | Rest], H, N) ->
    h_index(Rest, H + 1, N).