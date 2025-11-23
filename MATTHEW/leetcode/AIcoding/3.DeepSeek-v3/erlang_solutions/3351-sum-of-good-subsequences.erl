-module(solution).
-export([good_subsequences/1]).

good_subsequences(Nums) ->
    Counts = lists:foldl(fun(X, Acc) -> 
                            dict:update_counter(X, 1, Acc) 
                         end, dict:new(), Nums),
    UniqueNums = dict:fetch_keys(Counts),
    lists:foldl(fun(X, Acc) -> 
                   Acc + (dict:fetch(X, Counts) * (X + 1)) 
                end, 0, UniqueNums) - 1.