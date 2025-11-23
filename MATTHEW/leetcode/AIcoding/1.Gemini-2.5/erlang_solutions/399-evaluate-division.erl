-module(solution).
-export([calcEquation/3]).

calcEquation(Equations, Values, Queries) ->
    Graph = build_graph(Equations, Values),
    AllVars = get_all_vars(Graph),
    lists:map(fun([Start, End]) ->
                      solve_query(Start, End, Graph, AllVars)
              end, Queries).

build_graph(Equations, Values) ->
    lists:foldl(fun({[A, B], Val}, AccGraph) ->
                        NewAccGraph1 = maps:update_with(A, fun(M) -> maps:put(B, Val, M) end, #{B => Val}, AccGraph),
                        NewAccGraph2 = maps:update_with(B, fun(M) -> maps:put(A, 1.0 / Val, M) end, #{A => 1.0 / Val}, NewAccGraph1)
                end, #{}, lists:zip(Equations, Values)).

get_all_vars(Graph) ->
    maps:fold(fun(Var, _, AccSet) ->
                      sets:add_element(Var, AccSet)
              end, sets:new(), Graph).

solve_query(Start, End, Graph, AllVars) ->
    case {sets:is_element(Start, AllVars), sets:is_element(End, AllVars)} of
        {true, true} ->
            if Start == End -> 1.0;
               true ->
                   case dfs(Start, End, 1.0, sets:new(), Graph) of
                       no_path -> -1.0;
                       Result -> Result
                   end
            end;
        _ -> -1.0
    end.

dfs(Current, Target, CurrentProduct, Visited, Graph) ->
    if Current == Target ->
        CurrentProduct;
    true ->
        if sets:is_element(Current, Visited) ->
            no_path;
        true ->
            NewVisited = sets:add_element(Current, Visited),
            Neighbors = maps:get(Current, Graph, #{}),
            dfs_neighbors_loop(maps:to_list(Neighbors), Target, CurrentProduct, NewVisited, Graph)
        end
    end.

dfs_neighbors_loop([], _Target, _CurrentProduct, _Visited, _Graph) ->
    no_path;
dfs_neighbors_loop([{Neighbor, Weight} | Rest], Target, CurrentProduct, Visited, Graph) ->
    case dfs(Neighbor, Target, CurrentProduct * Weight, Visited, Graph) of
        no_path ->
            dfs_neighbors_loop(Rest, Target, CurrentProduct, Visited, Graph);
        Result ->
            Result
    end.