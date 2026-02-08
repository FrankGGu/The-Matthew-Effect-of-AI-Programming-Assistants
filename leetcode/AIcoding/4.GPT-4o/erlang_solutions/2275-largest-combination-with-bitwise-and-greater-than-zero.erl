-module(solution).
-export([largest_combination/1]).

largest_combination(Numbers) ->
    largest_combination_helper(Numbers, 0).

largest_combination_helper([], Max) -> 
    Max;
largest_combination_helper(Numbers, Max) ->
    NewMax = lists:foldl(fun(N, Acc) -> 
        Acc + (if 
            N band Max > 0 -> 1; 
            true -> 0 
        end) 
    end, 0, Numbers),
    largest_combination_helper(Numbers, NewMax).