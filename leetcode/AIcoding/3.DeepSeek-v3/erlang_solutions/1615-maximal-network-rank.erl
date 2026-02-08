-spec maximal_network_rank(N :: integer(), Roads :: [[integer()]]) -> integer().
maximal_network_rank(N, Roads) ->
    Degrees = lists:foldl(fun([U, V], Acc) ->
                                  maps:update_with(U, fun(D) -> D + 1 end, 1, 
                                  maps:update_with(V, fun(D) -> D + 1 end, 1, Acc)))
                          end, maps:new(), Roads),
    Max = 0,
    Cities = lists:seq(0, N - 1),
    lists:foldl(fun(I, CurrentMax) ->
        lists:foldl(fun(J, InnerMax) ->
            if 
                I == J -> InnerMax;
                true ->
                    DegreeI = maps:get(I, Degrees, 0),
                    DegreeJ = maps:get(J, Degrees, 0),
                    Connected = case lists:member([I, J], Roads) orelse lists:member([J, I], Roads) of
                                    true -> 1;
                                    false -> 0
                                end,
                    Rank = DegreeI + DegreeJ - Connected,
                    max(InnerMax, Rank)
            end
        end, CurrentMax, Cities)
    end, Max, Cities).