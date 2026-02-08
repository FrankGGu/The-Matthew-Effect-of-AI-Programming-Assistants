-module(solution).
-export([min_operations/2]).

min_operations(S, K) ->
    N = length(S),
    Groups = lists:seq(0, K - 1),
    Frequencies = lists:map(fun(I) ->
        lists:foldl(fun(X, Acc) ->
            case (lists:nth(I + 1, X) =:= $a) of
                true -> Acc + 1;
                false -> Acc
            end
        end, 0, lists:sublist(S, K))
    end, Groups),
    TotalChanges = lists:sum(Frequencies),
    MinOperations = lists:map(fun(F) -> N div K - F end, Frequencies),
    lists:min(MinOperations) + TotalChanges.