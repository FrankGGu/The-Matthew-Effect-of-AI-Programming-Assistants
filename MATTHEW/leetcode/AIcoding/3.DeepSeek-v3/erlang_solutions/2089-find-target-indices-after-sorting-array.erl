-spec target_indices(Nums :: [integer()], Target :: integer()) -> [integer()].
target_indices(Nums, Target) ->
    Sorted = lists:sort(Nums),
    lists:filtermap(fun({I, X}) -> 
                        case X =:= Target of
                            true -> {true, I};
                            false -> false
                        end
                    end, lists:zip(lists:seq(0, length(Sorted) - 1), Sorted).