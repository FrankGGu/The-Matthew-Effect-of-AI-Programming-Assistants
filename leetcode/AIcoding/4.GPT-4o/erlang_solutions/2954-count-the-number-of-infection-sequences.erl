-module(solution).
-export([count_infection_sequences/1]).

count_infection_sequences(R) ->
    N = length(R),
    Count = count_infections(R, N),
    Count.

count_infections(R, N) ->
    lists:sum(lists:map(fun(X) -> count_for_infection(X, R, N) end, lists:seq(1, N))).

count_for_infection(X, R, N) ->
    case lists:nth(X, R) of
        0 -> 0;
        _ -> count_combined_infections(X, R, N)
    end.

count_combined_infections(X, R, N) ->
    lists:foldl(fun(Y, Acc) ->
        if 
            lists:nth(Y, R) =:= 1 orelse lists:nth(X, R) =:= 1 -> 
                Acc + 1;
            true -> 
                Acc
        end
    end, 0, lists:seq(1, N)).