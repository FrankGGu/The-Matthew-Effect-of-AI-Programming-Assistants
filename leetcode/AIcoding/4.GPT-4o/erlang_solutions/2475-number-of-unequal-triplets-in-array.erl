-module(solution).
-export([count_unequal_triplets/1]).

count_unequal_triplets(Array) ->
    Unique = lists:usort(Array),
    Count = length(Unique),
    if Count < 3 -> 
        0;
    true ->
        TripletCount = 
            lists:foldl(fun(X, Acc) -> 
                Acc + (Count - lists:member(X, Unique)) * (Count - lists:member(X, Unique) - 1) div 2 
            end, 0, Unique),
        TripletCount div 6
    end.