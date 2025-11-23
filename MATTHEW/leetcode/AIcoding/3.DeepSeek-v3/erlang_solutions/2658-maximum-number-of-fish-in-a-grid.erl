-spec find_max_fish(Grid :: [[integer()]]) -> integer().
find_max_fish(Grid) ->
    Rows = length(Grid),
    case Rows of
        0 -> 0;
        _ ->
            Cols = length(hd(Grid)),
            Visited = sets:new(),
            MaxFish = lists:foldl(
                fun(I, Acc) ->
                    lists:foldl(
                        fun(J, InnerAcc) ->
                            case sets:is_element({I, J}, Visited) of
                                true -> InnerAcc;
                                false ->
                                    case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
                                        0 -> InnerAcc;
                                        Val ->
                                            {Sum, NewVisited} = dfs(I, J, Grid, Visited),
                                            max(InnerAcc, Sum)
                                    end
                            end
                        end,
                        Acc,
                        lists:seq(0, Cols - 1))
                end,
                0,
                lists:seq(0, Rows - 1)),
            MaxFish
    end.

dfs(I, J, Grid, Visited) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    case I < 0 orelse I >= Rows orelse J < 0 orelse J >= Cols orelse sets:is_element({I, J}, Visited) of
        true -> {0, Visited};
        false ->
            Cell = lists:nth(J + 1, lists:nth(I + 1, Grid)),
            case Cell of
                0 -> {0, sets:add_element({I, J}, Visited)};
                Val ->
                    NewVisited = sets:add_element({I, J}, Visited),
                    {Sum1, Visited1} = dfs(I + 1, J, Grid, NewVisited),
                    {Sum2, Visited2} = dfs(I - 1, J, Grid, Visited1),
                    {Sum3, Visited3} = dfs(I, J + 1, Grid, Visited2),
                    {Sum4, Visited4} = dfs(I, J - 1, Grid, Visited3),
                    {Val + Sum1 + Sum2 + Sum3 + Sum4, Visited4}
            end
    end.