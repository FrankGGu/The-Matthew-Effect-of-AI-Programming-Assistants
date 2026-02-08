-spec least_bricks(Wall :: [[integer()]]) -> integer().
least_bricks(Wall) ->
    EdgeCount = maps:new(),
    {EdgeCount1, MaxEdges} = lists:foldl(
        fun(Row, {Count, Max}) ->
            {NewCount, NewMax} = lists:foldl(
                fun(Brick, {AccCount, AccMax}) ->
                    case maps:get(Brick, AccCount, 0) of
                        undefined -> {maps:put(Brick, 1, AccCount), max(AccMax, 1)};
                        N -> {maps:put(Brick, N + 1, AccCount), max(AccMax, N + 1)}
                    end
                end,
                {Count, Max},
                lists:sublist(Row, 1, length(Row) - 1)
            ),
            {NewCount, NewMax}
        end,
        {EdgeCount, 0},
        Wall
    ),
    length(Wall) - MaxEdges.