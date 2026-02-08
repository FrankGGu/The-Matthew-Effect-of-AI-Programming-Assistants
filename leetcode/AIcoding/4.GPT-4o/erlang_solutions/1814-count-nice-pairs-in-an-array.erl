-module(solution).
-export([count_nice_pairs/1]).

count_nice_pairs(Nums) ->
    Pairs = maps:foldl(fun(X, Acc) -> 
        {A, B} = lists:foldl(fun(Y, {A, B}) -> 
            {A + (if (X == Y) -> 1; true -> 0 end), B + 1} 
        end, {0, 0}, Nums),
        Acc + A
    end, 0, Nums),
    Pairs rem 1000000007.