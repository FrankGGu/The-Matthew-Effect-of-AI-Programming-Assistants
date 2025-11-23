-module(solution).
-export([minimum_sum/1]).

minimum_sum(Nums) ->
    lists:foldl(fun(X, Acc) -> X + Acc end, 0, lists:sort(Nums)).

minimum_sum([]) ->
    0;
minimum_sum([N]) ->
    N;
minimum_sum([A,B|T]) ->
    A + B + minimum_sum(T).