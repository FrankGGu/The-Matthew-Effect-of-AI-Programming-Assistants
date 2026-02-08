-spec calc_equation(Equations :: [[unicode:unicode_binary()]], Values :: [float()], Queries :: [[unicode:unicode_binary()]]) -> [float()].
calc_equation(Equations, Values, Queries) ->
    G = build_graph(Equations, Values),
    lists:map(fun([A, B]) -> query(G, A, B) end, Queries).

build_graph(Equations, Values) ->
    lists:foldl(fun([A, B], V, G) ->
        G1 = add_edge(G, A, B, V),
        add_edge(G1, B, A, 1.0 / V)
    end, #{}, lists:zip(Equations, Values)).

add_edge(G, A, B, V) ->
    case maps:find(A, G) of
        {ok, Neighbors} -> G#{A => [{B, V} | Neighbors]};
        error -> G#{A => [{B, V}]}
    end.

query(G, A, B) ->
    case {maps:is_key(A, G), maps:is_key(B, G)} of
        {false, _} -> -1.0;
        {_, false} -> -1.0;
        {true, true} ->
            case A =:= B of
                true -> 1.0;
                false ->
                    Visited = sets:new(),
                    case dfs(G, A, B, Visited) of
                        {found, Res} -> Res;
                        not_found -> -1.0
                    end
            end
    end.

dfs(G, Node, Target, Visited) ->
    case Node =:= Target of
        true -> {found, 1.0};
        false ->
            case sets:is_element(Node, Visited) of
                true -> not_found;
                false ->
                    NewVisited = sets:add_element(Node, Visited),
                    Neighbors = maps:get(Node, G),
                    lists:foldl(fun({Next, V}, Acc) ->
                        case Acc of
                            not_found ->
                                case dfs(G, Next, Target, NewVisited) of
                                    {found, Res} -> {found, Res * V};
                                    not_found -> not_found
                                end;
                            _ -> Acc
                        end
                    end, not_found, Neighbors)
            end
    end.