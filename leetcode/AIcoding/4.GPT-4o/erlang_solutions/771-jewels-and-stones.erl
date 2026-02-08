-module(solution).
-export([num_jewels_in_stones/2]).

num_jewels_in_stones(J, S) ->
    J_set = sets:from_list(string:to_list(J)),
    Stones = string:to_list(S),
    lists:foldl(fun(X, Acc) -> 
        if sets:is_element(X, J_set) -> 
            Acc + 1; 
        true -> 
            Acc 
        end 
    end, 0, Stones).