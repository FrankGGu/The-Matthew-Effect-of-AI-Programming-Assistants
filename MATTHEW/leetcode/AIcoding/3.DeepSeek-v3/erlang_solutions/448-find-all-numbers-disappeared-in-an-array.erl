-spec find_disappeared_numbers(Nums :: [integer()]) -> [integer()].
find_disappeared_numbers(Nums) ->
    N = length(Nums),
    Marked = lists:foldl(fun(X, Acc) ->
                            Pos = abs(X) - 1,
                            case lists:nth(Pos + 1, Acc) > 0 of
                                true -> lists:sublist(Acc, Pos) ++ [-lists:nth(Pos + 1, Acc)] ++ lists:nthtail(Pos + 1, Acc);
                                false -> Acc
                            end
                         end, Nums, Nums),
    lists:filtermap(fun({Index, Val}) ->
                       if Val > 0 -> {true, Index + 1};
                          true -> false
                       end
                    end, lists:zip(lists:seq(0, N - 1), Marked)).