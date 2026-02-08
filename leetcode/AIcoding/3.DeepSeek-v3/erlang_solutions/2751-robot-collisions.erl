-spec robot_collisions(positions :: [integer()], healths :: [integer()], directions :: [char()]) -> [integer()].
robot_collisions(Positions, Healths, Directions) ->
    Robots = lists:zip3(Positions, Healths, Directions),
    SortedRobots = lists:sort(fun({P1, _, _}, {P2, _, _}) -> P1 =< P2 end, Robots),
    process_robots(SortedRobots, []).

process_robots([], Stack) ->
    lists:reverse([H || {_, H, _} <- Stack]);
process_robots([{P, H, D} | Rest], Stack) ->
    case Stack of
        [] ->
            process_robots(Rest, [{P, H, D} | Stack]);
        [{SP, SH, SD} | SRest] ->
            if
                D =:= $L andalso SD =:= $R ->
                    if
                        H =:= SH ->
                            process_robots(Rest, SRest);
                        H > SH ->
                            process_robots(Rest, [{P, H - 1, D} | SRest]);
                        true ->
                            process_robots([{SP, SH - 1, SD} | Rest], SRest)
                    end;
                D =:= $R andalso SD =:= $L ->
                    process_robots(Rest, [{P, H, D}, {SP, SH, SD} | SRest]);
                true ->
                    process_robots(Rest, [{P, H, D} | Stack])
            end
    end.