-spec length_of_lis(Nums :: [integer()]) -> integer().
length_of_lis(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            DP = lists:foldl(fun(N, Acc) ->
                case lists:search(fun(X) -> X >= N end, Acc) of
                    {pos, Index} ->
                        lists:sublist(Acc, Index - 1) ++ [N | lists:nthtail(Index, Acc)];
                    false ->
                        Acc ++ [N]
                end
            end, [], Nums),
            length(DP)
    end.