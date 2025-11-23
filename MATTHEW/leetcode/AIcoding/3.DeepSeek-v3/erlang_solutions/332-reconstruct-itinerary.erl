-spec find_itinerary(Tickets :: [[binary()]]) -> [binary()].
find_itinerary(Tickets) ->
    Graph = build_graph(Tickets),
    Itinerary = dfs("JFK", Graph),
    lists:reverse(Itinerary).

build_graph(Tickets) ->
    lists:foldl(fun([From, To], Acc) ->
        case maps:find(From, Acc) of
            {ok, Destinations} ->
                maps:put(From, lists:sort([To | Destinations]), Acc);
            error ->
                maps:put(From, [To], Acc)
        end
    end, maps:new(), Tickets).

dfs(Node, Graph) ->
    dfs(Node, Graph, []).

dfs(Node, Graph, Path) ->
    case maps:find(Node, Graph) of
        {ok, []} ->
            [Node | Path];
        {ok, [Next | Rest]} ->
            NewGraph = maps:put(Node, Rest, Graph),
            dfs(Next, NewGraph, [Node | Path]);
        error ->
            [Node | Path]
    end.