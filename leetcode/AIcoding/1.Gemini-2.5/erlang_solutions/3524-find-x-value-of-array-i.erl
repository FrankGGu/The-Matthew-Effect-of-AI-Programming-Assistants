-module(solution).
-export([specialArray/1]).

specialArray(Nums) ->
    N = length(Nums),
    find_x(0, N, Nums).

find_x(X, N, Nums) when X =< N ->
    Count = count_greater_or_equal(X, Nums),
    case Count of
        X -> X;
        _ -> find_x(X + 1, N, Nums)
    end;
find_x(_X, _N, _Nums) ->
    -1.

count_greater_or_equal(X, Nums) ->
    lists:foldl(fun(Num, Acc) ->
                    if Num >= X -> Acc + 1;
                       true -> Acc
                    end
                end, 0, Nums).