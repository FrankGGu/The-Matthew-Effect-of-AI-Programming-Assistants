-module(solution).
-export([earliest_second_to_mark_indices_i/1]).

earliest_second_to_mark_indices_i(Indices) ->
    lists:foldl(fun(Index, Acc) -> 
        case lists:nth(Index + 1, Acc) of 
            undefined -> Acc ++ [1]; 
            _ -> Acc ++ [lists:nth(Index + 1, Acc) + 1] 
        end 
    end, [0], Indices).