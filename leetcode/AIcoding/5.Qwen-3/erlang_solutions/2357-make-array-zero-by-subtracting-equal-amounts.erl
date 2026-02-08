-module(solution).
-export([minimum_subtract_operations/1]).

minimum_subtract_operations(A) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of
            true -> Acc;
            false -> [X | Acc]
        end
    end, [], A),
    lists:reverse(lists:usort(A)),
    lists:foldl(fun(X, Acc) -> Acc + 1 end, 0, lists:usort(A)).