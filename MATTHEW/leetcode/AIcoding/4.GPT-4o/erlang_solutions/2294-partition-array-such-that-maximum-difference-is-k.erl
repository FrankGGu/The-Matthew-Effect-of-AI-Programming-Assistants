-module(solution).
-export([partition/2]).

partition(A, K) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:keyfind(X, 1, Acc) of
            false -> [{X, 1}] ++ Acc;
            {Y, N} -> [{Y, N + 1}] ++ lists:keydelete(Y, 1, Acc)
        end
    end, [], A).