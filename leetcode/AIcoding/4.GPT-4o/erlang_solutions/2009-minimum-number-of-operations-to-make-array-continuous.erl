-module(solution).
-export([min_operations/1]).

min_operations(A) ->
    N = length(A),
    Sorted = lists:sort(A),
    Max_len = lists:max([count_range(Sorted, X, N) || X <- Sorted]),
    N - Max_len.

count_range(Sorted, X, N) ->
    Start = X,
    End = X + N - 1,
    lists:foldl(fun(Y, Acc) -> 
        case Y of
            _ when Y >= Start, Y =< End -> Acc + 1;
            _ -> Acc
        end
    end, 0, Sorted).