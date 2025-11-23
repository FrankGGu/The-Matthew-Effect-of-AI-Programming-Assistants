-spec min_cost(Costs :: [[integer()]]) -> integer().
min_cost(Costs) ->
    case Costs of
        [] -> 0;
        _ ->
            DP = lists:foldl(fun(Cost, [R, G, B]) ->
                NewR = Cost ++ [0] ++ [0],
                NewG = [0] ++ Cost ++ [0],
                NewB = [0] ++ [0] ++ Cost,
                [
                    lists:min([G, B]) + hd(NewR),
                    lists:min([R, B]) + hd(tl(NewG)),
                    lists:min([R, G]) + hd(tl(tl(NewB)))
                ]
            end, [0, 0, 0], Costs),
            lists:min(DP)
    end.