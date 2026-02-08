-module(solution).
-export([numberOfDistinctIntegers/1]).

numberOfDistinctIntegers(N) ->
    Count = N,
    lists:foldl(fun(I, Acc) -> 
        case I rem 2 of
            0 -> Acc;
            _ -> sets:add_element(I, Acc)
        end
    end, sets:new(), lists:seq(1, Count)).