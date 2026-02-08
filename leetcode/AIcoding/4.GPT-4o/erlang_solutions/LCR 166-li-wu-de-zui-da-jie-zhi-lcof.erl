-module(solution).
-export([maxJewels/2]).

maxJewels(J, S) ->
    counts = lists:foldl(fun(X, Acc) -> 
        case lists:keyfind(X, 1, Acc) of
            false -> [{X, 1} | Acc];
            {X, N} -> lists:keyreplace(X, 1, Acc, {X, N + 1})
        end
    end, [], S),
    lists:foldl(fun({X, N}, Acc) -> 
        case lists:keyfind(X, 1, J) of
            false -> Acc;
            {X, V} -> Acc + V * N
        end
    end, 0, counts).