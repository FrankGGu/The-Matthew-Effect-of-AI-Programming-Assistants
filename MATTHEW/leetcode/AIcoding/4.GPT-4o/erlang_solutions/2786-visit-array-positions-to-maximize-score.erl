-module(solution).
-export([maxScore/1]).

maxScore(Array) ->
    N = length(Array),
    MaxScore = lists:foldl(fun(X, Acc) -> 
        case lists:keyfind(X, 1, Acc) of
            false -> [{X, 1} | Acc];
            {X, C} -> lists:keyreplace(X, 1, Acc, {X, C + 1})
        end
    end, [], Array),
    lists:foldl(fun({X, C}, Acc) -> 
        case C rem 3 of
            0 -> Acc + X;
            _ -> Acc
        end
    end, 0, MaxScore).