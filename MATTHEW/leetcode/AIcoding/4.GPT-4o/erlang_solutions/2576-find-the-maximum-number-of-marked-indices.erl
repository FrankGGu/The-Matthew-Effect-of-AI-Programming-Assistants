-module(solution).
-export([max_marked_indices/1]).

max_marked_indices(List) ->
    Sorted = lists:sort(List),
    max_marked_indices_helper(Sorted, 0).

max_marked_indices_helper([], Acc) -> Acc;
max_marked_indices_helper([H|T], Acc) ->
    NewAcc = lists:foldl(fun(X, Acc1) -> 
        if 
            X * 2 <= H -> Acc1 + 1; 
            true -> Acc1 
        end 
    end, Acc, T),
    max_marked_indices_helper(T, NewAcc).