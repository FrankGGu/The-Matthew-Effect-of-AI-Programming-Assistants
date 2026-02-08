-spec running_sum(Nums :: [integer()]) -> [integer()].
running_sum(Nums) ->
    lists:reverse(lists:foldl(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            [H|_] -> [X + H | Acc]
        end
    end, [], Nums)).