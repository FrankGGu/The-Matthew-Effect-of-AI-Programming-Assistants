-module(solution).
-export([sum_subarray_mins/1]).

sum_subarray_mins(A) ->
    N = length(A),
    Stack = [],
    MinSum = 0,
    Pushed = lists:foldl(fun(X, {S, P}) -> 
        {S + X * (length(P) + 1), [X | P]} 
    end, {0, []}, A),
    lists:foldl(fun(X, {S, P}) -> 
        case P of 
            [] -> {S, []}; 
            [H | T] when H < X -> 
                {S + H * (length(P) + 1), [H | T]}; 
            _ -> {S, [X | P]} 
        end 
    end, Pushed, A),
    MinSum rem 1000000007.