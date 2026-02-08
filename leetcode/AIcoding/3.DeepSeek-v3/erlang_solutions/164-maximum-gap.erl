-spec maximum_gap(Nums :: [integer()]) -> integer().
maximum_gap(Nums) ->
    case length(Nums) < 2 of
        true -> 0;
        false ->
            Sorted = lists:sort(Nums),
            lists:foldl(fun({X, Y}, Max) -> max(Y - X, Max) end, 0, 
                        lists:zip(lists:sublist(Sorted, length(Sorted) - 1), 
                                 lists:nthtail(1, Sorted)))
    end.