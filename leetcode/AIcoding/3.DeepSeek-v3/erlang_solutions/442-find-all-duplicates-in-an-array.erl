-spec find_duplicates(Nums :: [integer()]) -> [integer()].
find_duplicates(Nums) ->
    lists:foldl(fun(N, Acc) ->
                    case lists:nth(abs(N), Nums) < 0 of
                        true -> [abs(N) | Acc];
                        false -> lists:sublist(Nums, 1, abs(N) - 1) ++ 
                                 [-lists:nth(abs(N), Nums)] ++ 
                                 lists:sublist(Nums, abs(N) + 1, length(Nums) - abs(N))
                    end
                end, [], Nums),
    lists:reverse(lists:foldl(fun(N, Acc) ->
                                case lists:nth(abs(N), Nums) < 0 of
                                    true -> [abs(N) | Acc];
                                    false -> Acc
                                end
                             end, [], Nums)).