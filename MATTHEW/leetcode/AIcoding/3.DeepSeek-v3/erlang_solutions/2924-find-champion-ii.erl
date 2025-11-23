-spec find_champion(N :: integer(), Edges :: [[integer()]]) -> integer().
find_champion(N, Edges) ->
    InDegree = lists:foldl(fun([_, To], Acc) ->
                            maps:update_with(To, fun(V) -> V + 1 end, 1, Acc)
                           end, maps:new(), Edges),
    case lists:filter(fun(I) -> not maps:is_key(I, InDegree) end, lists:seq(0, N - 1)) of
        [Champion] -> Champion;
        _ -> -1
    end.