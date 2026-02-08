-spec answer_queries(Nums :: [integer()], Queries :: [integer()]) -> [integer()].
answer_queries(Nums, Queries) ->
    Sorted = lists:sort(Nums),
    Prefix = lists:foldl(fun(X, Acc) -> [X + hd(Acc) | tl(Acc)] end, [0], Sorted),
    lists:map(fun(Q) -> 
        lists:foldl(fun(X, Count) -> 
            case X =< Q of
                true -> Count + 1;
                false -> Count
            end
        end, 0, tl(Prefix))
    end, Queries).