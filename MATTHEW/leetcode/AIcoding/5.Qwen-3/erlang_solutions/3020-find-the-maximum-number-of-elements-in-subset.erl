-module(solution).
-export([max_elements/1]).

max_elements(Nums) ->
    Max = lists:max(Nums),
    Count = count(Max, Nums),
    Count.

count(_, []) -> 0;
count(X, [H|T]) ->
    if H == X -> 1 + count(X, T);
       true -> count(X, T)
    end.