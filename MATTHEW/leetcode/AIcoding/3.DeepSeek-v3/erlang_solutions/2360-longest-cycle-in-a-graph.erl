-spec longest_cycle(Edges :: [integer()]) -> integer().
longest_cycle(Edges) ->
    N = length(Edges),
    Visited = array:new([{size, N}, {default, false}]),
    MaxCycle = -1,
    {MaxCycle, _} = lists:foldl(
        fun(Node, {CurrentMax, VisitedArr}) ->
            case array:get(Node, VisitedArr) of
                false ->
                    {CycleLen, NewVisited} = dfs(Node, Edges, VisitedArr, #{}),
                    NewMax = max(CurrentMax, CycleLen),
                    {NewMax, NewVisited};
                true ->
                    {CurrentMax, VisitedArr}
            end
        end,
        {MaxCycle, Visited},
        lists:seq(0, N - 1)
    ),
    MaxCycle.

dfs(Node, Edges, Visited, Path) ->
    case array:get(Node, Visited) of
        true ->
            case maps:get(Node, Path, undefined) of
                undefined -> {-1, Visited};
                StartIndex -> {maps:size(Path) - StartIndex, Visited}
            end;
        false ->
            NewVisited = array:set(Node, true, Visited),
            NextNode = lists:nth(Node + 1, Edges),
            case NextNode of
                -1 -> {-1, NewVisited};
                _ ->
                    NewPath = maps:put(Node, maps:size(Path), Path),
                    dfs(NextNode, Edges, NewVisited, NewPath)
            end
    end.