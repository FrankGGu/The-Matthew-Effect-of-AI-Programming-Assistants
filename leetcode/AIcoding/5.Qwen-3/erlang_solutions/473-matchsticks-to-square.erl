-module(solution).
-export([can_match/1]).

can_match(Sticks) ->
    Total = lists:sum(Sticks),
    case Total rem 4 of
        0 ->
            PerSide = Total div 4,
            if
                PerSide == 0 -> false;
                true -> dfs(Sticks, PerSide, 0, 0, 0, 0, [])
            end;
        _ -> false
    end.

dfs([], _, _, _, _, _, _) -> true;
dfs(Sticks, PerSide, A, B, C, D, Acc) ->
    case length(Acc) of
        0 -> dfs(Sticks, PerSide, A, B, C, D, [lists:nth(1, Sticks)]);
        _ ->
            case {A + hd(Acc), B + hd(Acc), C + hd(Acc), D + hd(Acc)} of
                {A1, B1, C1, D1} when A1 > PerSide -> dfs(Sticks, PerSide, A, B, C, D, tl(Acc));
                {A1, B1, C1, D1} when B1 > PerSide -> dfs(Sticks, PerSide, A, B, C, D, tl(Acc));
                {A1, B1, C1, D1} when C1 > PerSide -> dfs(Sticks, PerSide, A, B, C, D, tl(Acc));
                {A1, B1, C1, D1} when D1 > PerSide -> dfs(Sticks, PerSide, A, B, C, D, tl(Acc));
                _ ->
                    case {A1, B1, C1, D1} of
                        {PerSide, B1, C1, D1} -> dfs(Sticks, PerSide, 0, B1, C1, D1, []);
                        {A1, PerSide, C1, D1} -> dfs(Sticks, PerSide, A1, 0, C1, D1, []);
                        {A1, B1, PerSide, D1} -> dfs(Sticks, PerSide, A1, B1, 0, D1, []);
                        {A1, B1, C1, PerSide} -> dfs(Sticks, PerSide, A1, B1, C1, 0, []);
                        _ -> dfs(Sticks, PerSide, A1, B1, C1, D1, tl(Acc))
                    end
            end
    end.