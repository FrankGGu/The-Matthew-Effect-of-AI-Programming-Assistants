-module(solution).
-export([find_score/1]).

find_score(Array) ->
    Sorted = lists:sort(Array),
    Marked = lists:map(fun(X) -> {X, false} end, Sorted),
    Score = lists:foldl(fun(X, Acc) ->
        case lists:keyfind(X, 1, Acc) of
            false -> Acc;
            {X, false} ->
                UpdatedAcc = lists:map(fun({V, M}) -> 
                    if V == X orelse V == X + 1 orelse V == X - 1 -> {V, true}; 
                       true -> {V, M} 
                    end 
                end, Acc),
                X + lists:sum([V || {V, true} <- UpdatedAcc])
            _ -> Acc
        end
    end, 0, Sorted),
    Score.