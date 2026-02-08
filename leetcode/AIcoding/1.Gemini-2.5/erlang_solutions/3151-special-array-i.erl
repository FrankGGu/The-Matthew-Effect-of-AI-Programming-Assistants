-module(solution).
-export([special_array/1]).

special_array(Nums) ->
    Len = length(Nums),
    find_x(1, Len, Nums).

find_x(X, MaxX, Nums) when X =< MaxX ->
    Count = count_ge_x(X, Nums),
    if
        Count == X -> X;
        true -> find_x(X + 1, MaxX, Nums)
    end;
find_x(_X, _MaxX, _Nums) ->
    -1.

count_ge_x(X, Nums) ->
    lists:foldl(fun(Num, Acc) ->
                    if
                        Num >= X -> Acc + 1;
                        true -> Acc
                    end
                end, 0, Nums).