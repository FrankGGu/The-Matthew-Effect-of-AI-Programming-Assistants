-spec maximum_invitations(Favorite :: [integer()]) -> integer().
maximum_invitations(Favorite) ->
    N = length(Favorite),
    Visited = array:new([{size, N}, {default, false}]),
    InDegree = array:new([{size, N}, {default, 0}]),
    lists:foreach(fun(I) ->
        J = lists:nth(I + 1, Favorite),
        array:set(J, array:get(J, InDegree) + 1, InDegree)
    end, lists:seq(0, N - 1)),
    Queue = [I || I <- lists:seq(0, N - 1), array:get(I, InDegree) == 0],
    {TopoOrder, _} = lists:foldl(fun(_, {Order, Q}) ->
        case Q of
            [] -> {Order, []};
            [U | Rest] ->
                V = lists:nth(U + 1, Favorite),
                NewInDegree = array:get(V, InDegree) - 1,
                NewInDegreeArray = array:set(V, NewInDegree, InDegree),
                NewQ = if
                    NewInDegree == 0 -> Rest ++ [V];
                    true -> Rest
                end,
                {Order ++ [U], NewQ}
        end
    end, {[], Queue}, lists:seq(1, N)),
    lists:foreach(fun(U) ->
        V = lists:nth(U + 1, Favorite),
        array:set(V, array:get(V, InDegree) - 1, InDegree)
    end, TopoOrder),
    MaxCycle = 0,
    TwoCycles = 0,
    {FinalMaxCycle, FinalTwoCycles} = lists:foldl(fun(U, {MC, TC}) ->
        case not array:get(U, Visited) of
            true ->
                V = lists:nth(U + 1, Favorite),
                if
                    V == lists:nth(V + 1, Favorite) ->
                        {MC, TC + 1};
                    true ->
                        Length = 1,
                        Current = V,
                        array:set(U, true, Visited),
                        {NewLength, NewVisited} = dfs(Current, U, Length, Visited, Favorite),
                        {max(MC, NewLength), TC}
                end;
            false ->
                {MC, TC}
        end
    end, {MaxCycle, TwoCycles}, lists:seq(0, N - 1)),
    max(FinalMaxCycle, FinalTwoCycles).

dfs(Current, Start, Length, Visited, Favorite) ->
    case Current == Start of
        true ->
            {Length, Visited};
        false ->
            case array:get(Current, Visited) of
                true ->
                    {0, Visited};
                false ->
                    array:set(Current, true, Visited),
                    Next = lists:nth(Current + 1, Favorite),
                    dfs(Next, Start, Length + 1, Visited, Favorite)
            end
    end.