-spec find_max_k(Nums :: [integer()]) -> integer().
find_max_k(Nums) ->
    Set = sets:from_list(Nums),
    lists:foldl(fun(X, Acc) ->
                    case sets:is_element(-X, Set) of
                        true -> max(X, Acc);
                        false -> Acc
                    end
                end, -1, lists:sort(fun(A, B) -> A > B end, Nums)).