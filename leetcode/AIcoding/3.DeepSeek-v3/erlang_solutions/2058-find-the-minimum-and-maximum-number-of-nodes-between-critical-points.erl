-spec nodes_between_critical_points(Head :: [integer()]) -> [integer()].
nodes_between_critical_points(Head) ->
    case Head of
        [] -> [-1, -1];
        [_] -> [-1, -1];
        [_, _] -> [-1, -1];
        _ ->
            {Indices, _} = lists:foldl(fun
                (_, {[], [_, _] = Prev}) -> {[], Prev};
                (Val, {Acc, [P1, P2]}) ->
                    case (Val > P2 andalso P2 < P1) orelse (Val < P2 andalso P2 > P1) of
                        true -> {[0 | Acc], [P2, Val]};
                        false -> {Acc, [P2, Val]}
                    end
            end, {[], tl(Head)}, tl(tl(Head))),
            CPs = lists:reverse(Indices),
            case CPs of
                [] -> [-1, -1];
                [_] -> [-1, -1];
                _ ->
                    Dists = [Y - X || {X, Y} <- lists:zip(CPs, tl(CPs))],
                    Min = lists:min(Dists),
                    Max = lists:nth(length(CPs), CPs) - lists:nth(1, CPs),
                    [Min, Max]
            end
    end.