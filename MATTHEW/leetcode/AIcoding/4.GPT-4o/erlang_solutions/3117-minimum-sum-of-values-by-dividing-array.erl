-module(solution).
-export([min_sum_divide/2]).

min_sum_divide(Numbers, K) ->
    Sorted = lists:sort(Numbers),
    divide(Sorted, K).

divide(Numbers, K) ->
    lists:foldl(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            [H | T] -> 
                [H + X | T]
        end 
    end, [], lists:sublist(Numbers, K)).