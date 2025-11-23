-spec count_visited_nodes(Edges :: [integer()]) -> [integer()].
count_visited_nodes(Edges) ->
    N = length(Edges),
    Visited = array:new([{size, N}, {default, -1}]),
    Ans = array:new([{size, N}, {default, 0}]),
    {Ans1, _} = lists:foldl(fun(Node, {AnsAcc, VisitedAcc}) ->
        case array:get(Node, VisitedAcc) of
            -1 ->
                {Path, CycleFound} = find_cycle(Node, Edges, VisitedAcc, []),
                {CycleLen, AnsAcc1, VisitedAcc1} = 
                    case CycleFound of
                        true ->
                            {CycleStart, Cycle} = lists:splitwith(fun(X) -> X =/= hd(Path) end, Path),
                            CycleLen1 = length(Cycle),
                            {AnsAcc2, VisitedAcc2} = lists:foldl(fun(X, {AnsAccIn, VisitedAccIn}) ->
                                {array:set(X, CycleLen1, AnsAccIn), array:set(X, 0, VisitedAccIn)}
                            end, {AnsAcc, VisitedAcc}, Cycle),
                            {CycleLen1, AnsAcc2, VisitedAcc2};
                        false ->
                            {0, AnsAcc, VisitedAcc}
                    end,
                {AnsAcc2, VisitedAcc2} = lists:foldl(fun({X, Dist}, {AnsAccIn, VisitedAccIn}) ->
                    case array:get(X, VisitedAccIn) of
                        -1 ->
                            {array:set(X, Dist + CycleLen, AnsAccIn), array:set(X, 0, VisitedAccIn)};
                        _ ->
                            {AnsAccIn, VisitedAccIn}
                    end
                end, {AnsAcc1, VisitedAcc1}, lists:zip(Path, lists:seq(1, length(Path)))),
                {AnsAcc2, VisitedAcc2};
            _ ->
                {AnsAcc, VisitedAcc}
        end
    end, {Ans, Visited}, lists:seq(0, N - 1)),
    array:to_list(Ans1).

find_cycle(Node, Edges, Visited, Path) ->
    case array:get(Node, Visited) of
        -1 ->
            Visited1 = array:set(Node, length(Path), Visited),
            Next = lists:nth(Node + 1, Edges),
            find_cycle(Next, Edges, Visited1, [Node | Path]);
        Dist ->
            {lists:reverse([Node | Path]), Dist =/= 0}
    end.