-module(solution).
-export([solve/3]).

solve(Equations, Values, Queries) ->
    Graph = build_graph(Equations, Values),
    lists:map(fun(Query) ->
                  evaluate_query(Query, Graph)
              end, Queries).

build_graph(Equations, Values) ->
    lists:foldl(fun({[A, B], V}, AccGraph) ->
                    A_atom = list_to_atom(A),
                    B_atom = list_to_atom(B),
                    AccGraph1 = maps:update_with(A_atom, fun(M) -> maps:put(B_atom, V, M) end, #{B_atom => V}, AccGraph),
                    maps:update_with(B_atom, fun(M) -> maps:put(A_atom, 1.0 / V, M) end, #{A_atom => 1.0 / V}, AccGraph1)
                end, #{}, lists:zip(Equations, Values)).

evaluate_query([Start, End], Graph) ->
    Start_atom = list_to_atom(Start),
    End_atom = list_to_atom(End),

    case {maps:is_key(Start_atom, Graph), maps:is_key(End_atom, Graph)} of
        {true, true} ->
            if Start_atom == End_atom ->
                    1.0;
                true ->
                    dfs(Graph, Start_atom, End_atom)
            end;
        _ ->
            -1.0
    end.

dfs(Graph, Start, Target) ->
    Visited = sets:new(),
    case dfs_recursive(Graph, Start, Target, 1.0, Visited) of
        {found, Result} -> Result;
        not_found -> -1.0
    end.

dfs_recursive(Graph, Current, Target, AccProduct, Visited) ->
    if Current == Target ->
        {found, AccProduct};
    elseif sets:is_element(Current, Visited) ->
        not_found;
    else
        NewVisited = sets:add_element(Current, Visited),
        Neighbors = maps:get(Current, Graph, #{}),

        lists:foldl(fun({Neighbor, Weight}, AccResult) ->
                        case AccResult of
                            {found, _} -> AccResult;
                            not_found ->
                                dfs_recursive(Graph, Neighbor, Target, AccProduct * Weight, NewVisited)
                        end
                    end, not_found, maps:to_list(Neighbors))
    end.