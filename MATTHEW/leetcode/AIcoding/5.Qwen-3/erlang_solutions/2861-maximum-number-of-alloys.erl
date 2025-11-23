-module(max_number_of_alloys).
-export([max_number_of_alloys/2]).

max_number_of_alloys(Params, K) ->
    [M, R, S] = Params,
    lists:foldl(fun(Num, Acc) -> 
        case (R * Num) >= S of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, M).

max_number_of_alloys(M, R, S, K) ->
    max_number_of_alloys([M, R, S], K).