-spec count_pairs(n :: integer(), edges :: [[integer()]]) -> integer().
count_pairs(N, Edges) ->
    Parent = lists:seq(0, N - 1),
    Rank = lists:duplicate(N, 1),
    {Parent1, Rank1} = lists:foldl(fun([U, V], {P, R}) ->
        {Union(P, R, U + 1, V + 1), R}
    end, {Parent, Rank}, Edges),
    SizeMap = lists:foldl(fun(Node, Map) ->
        Root = find(Parent1, Node + 1),
        maps:update_with(Root, fun(Count) -> Count + 1 end, 1, Map)
    end, #{}, lists:seq(0, N - 1)),
    Sizes = maps:values(SizeMap),
    Total = lists:sum(Sizes),
    lists:foldl(fun(Size, Acc) ->
        Acc + Size * (Total - Size)
    end, 0, Sizes) div 2.

find(Parent, Node) ->
    case lists:nth(Node, Parent) of
        Node -> Node;
        P -> find(Parent, P)
    end.

union(Parent, Rank, X, Y) ->
    RootX = find(Parent, X),
    RootY = find(Parent, Y),
    if
        RootX =:= RootY -> Parent;
        true ->
            RankX = lists:nth(RootX, Rank),
            RankY = lists:nth(RootY, Rank),
            if
                RankX > RankY ->
                    setelement(RootY, Parent, RootX),
                    setelement(RootX, Rank, RankX + RankY),
                    Parent;
                true ->
                    setelement(RootX, Parent, RootY),
                    setelement(RootY, Rank, RankX + RankY),
                    Parent
            end
    end.