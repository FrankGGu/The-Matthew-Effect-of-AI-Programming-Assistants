-module(solution).
-export([specialArray/1]).

specialArray(Nums) ->
    N = length(Nums),
    find_x(0, N, Nums).

find_x(X, MaxX, Nums) when X =< MaxX ->
    Count = count_greater_or_equal(X, Nums),
    if
        Count == X ->
            X;
        true ->
            find_x(X + 1, MaxX, Nums)
    end;
find_x(_X, _MaxX, _Nums) ->
    -1.

count_greater_or_equal(X, Nums) ->
    lists:foldl(fun(Num, Acc) ->
        if
            Num >= X -> Acc + 1;
            true -> Acc
        end
    end, 0, Nums).