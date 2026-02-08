-spec component_value(nums :: [integer()], edges :: [[integer()]]) -> integer().
component_value(Nums, Edges) ->
    Total = lists:sum(Nums),
    Max = lists:max(Nums),
    Factors = [X || X <- lists:seq(1, Total), Total rem X =:= 0, X >= Max],
    case Factors of
        [] -> 0;
        _ ->
            lists:foldl(fun(Factor, Acc) ->
                case check_factor(Nums, Edges, Factor) of
                    true -> max(Acc, Total div Factor - 1);
                    false -> Acc
                end
            end, 0, Factors)
    end.

check_factor(Nums, Edges, Factor) ->
    N = length(Nums),
    Adj = lists:foldl(fun([U, V], Acc) ->
        maps:update_with(U, fun(L) -> [V | L] end, [V], Acc)
    end, maps:from_list([{I, []} || I <- lists:seq(0, N - 1)]), Edges),
    Visited = array:new(N, {default, false}),
    {Res, _} = dfs(0, Nums, Adj, Visited, Factor),
    Res.

dfs(Node, Nums, Adj, Visited, Factor) ->
    case array:get(Node, Visited) of
        true -> {true, 0};
        false ->
            NewVisited = array:set(Node, true, Visited),
            Children = maps:get(Node, Adj, []),
            Sum = lists:foldl(fun(Child, {Res, Acc}) ->
                case Res of
                    false -> {false, 0};
                    true ->
                        {ChildRes, ChildSum} = dfs(Child, Nums, Adj, NewVisited, Factor),
                        {ChildRes, Acc + ChildSum}
                end
            end, {true, 0}, Children),
            case Sum of
                {false, _} -> {false, 0};
                {true, ChildSum} ->
                    Total = ChildSum + lists:nth(Node + 1, Nums),
                    if
                        Total > Factor -> {false, 0};
                        Total =:= Factor -> {true, 0};
                        true -> {true, Total}
                    end
            end
    end.