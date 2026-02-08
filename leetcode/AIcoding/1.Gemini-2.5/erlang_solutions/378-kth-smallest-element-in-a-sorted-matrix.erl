-module(solution).
-export([kthSmallest/2]).

kthSmallest(Matrix, K) ->
    Flattened = lists:append(Matrix),
    Sorted = lists:sort(Flattened),
    lists:nth(K, Sorted).