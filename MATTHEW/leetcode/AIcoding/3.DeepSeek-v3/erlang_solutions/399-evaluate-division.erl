-spec calc_equation(Equations :: [[unicode:unicode_binary()]], Values :: [float()], Queries :: [[unicode:unicode_binary()]]) -> [float()].
calc_equation(Equations, Values, Queries) ->
    Graph = build_graph(Equations, Values),
    lists:map(fun([A, B]) -> query(Graph, A, B) end, Queries).

build_graph(Equations, Values) ->
    lists:foldl(fun({[A, B], Val}, Acc) ->
        Acc1 = add_edge(A, B, Val, Acc),
        add_edge(B, A, 1.0 / Val, Acc1)
    end, #{}, lists:zip(Equations, Values)).

add_edge(A, B, Val, Graph) ->
    case maps:find(A, Graph) of
        {ok, Edges} -> Graph#{A => [{B, Val} | Edges]};
        error -> Graph#{A => [{B, Val}]}
    end.

query(Graph, A, B) ->
    case {maps:is_key(A, Graph), maps:is_key(B, Graph)} of
        {false, _} -> -1.0;
        {_, false} -> -1.0;
        _ ->
            case A =:= B of
                true -> 1.0;
                false ->
                    Visited = sets:new([{version, 2}]),
                    dfs(Graph, A, B, Visited, 1.0)
            end
    end.

dfs(Graph, Current, Target, Visited, Product) ->
    case Current =:= Target of
        true -> Product;
        false ->
            case sets:is_element(Current, Visited) of
                true -> -1.0;
                false ->
                    NewVisited = sets:add_element(Current, Visited),
                    Edges = maps:get(Current, Graph),
                    lists:foldl(fun({Next, Val}, Acc) ->
                        case Acc =:= -1.0 of
                            true -> dfs(Graph, Next, Target, NewVisited, Product * Val);
                            false -> Acc
                        end
                    end, -1.0, Edges)
            end
    end.