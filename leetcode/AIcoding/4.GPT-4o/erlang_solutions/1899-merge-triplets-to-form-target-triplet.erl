-module(solution).
-export([merge_triplets/2]).

merge_triplets(Triplets, Target) ->
    lists:any(fun(Triplet) -> 
        lists:all(fun({T, R}) -> T =< R end, lists:zip(Triplet, Target)) 
    end, Triplets) orelse lists:any(fun(Triplet) -> 
        lists:all(fun({T, R}) -> T =< R end, lists:zip(Triplet, lists:map(fun(X) -> -1 * X end, Target))) 
    end, Triplets).