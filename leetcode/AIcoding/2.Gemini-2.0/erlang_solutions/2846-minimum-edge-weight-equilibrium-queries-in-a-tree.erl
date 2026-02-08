-module(minimum_edge_weight_equilibrium_queries).
-export([minimum_edge_weight_equilibrium_queries/2]).

minimum_edge_weight_equilibrium_queries(N, Edges, Queries) ->
    Adj = lists:foldl(
        fun([U, V, W], Acc) ->
            Acc#{U => [{V, W} | maps:get(U, Acc, [])],
                  V => [{U, W} | maps:get(V, Acc, [])]},
        #{},
        Edges
    ),

    LCA_Table = build_lca_table(N, Adj),

    lists:map(
        fun([U, V, Threshold]) ->
            process_query(U, V, Threshold, Adj, LCA_Table)
        end,
        Queries
    ).

build_lca_table(N, Adj) ->
    Depth = array:new([N + 1, N + 1], undefined),
    Parent = array:new([N + 1, N + 1], undefined),

    dfs(1, 0, 0, Adj, Depth, Parent),

    for(I, 1, 20, 
        fun(I) ->
            for(J, 1, N, 
                fun(J) ->
                    if
                        array:get(J, Parent) /= undefined ->
                            P = array:get(J, Parent);
                            if
                                array:get(P, Parent) /= undefined ->
                                    array:set(J, array:set(P, array:get(J, Parent), Parent), Parent);
                                true ->
                                    ok
                            end;
                        true ->
                            ok
                    end
                end
            )
        end
    ),

    #{depth => Depth, parent => Parent}.

dfs(Node, Par, Dep, Adj, Depth, Parent) ->
    array:set(Node, Dep, Depth),
    array:set(Node, Par, Parent),

    lists:foreach(
        fun({Neighbor, _Weight}) ->
            if
                array:get(Neighbor, Depth) == undefined ->
                    dfs(Neighbor, Node, Dep + 1, Adj, Depth, Parent);
                true ->
                    ok
            end
        end,
        maps:get(Node, Adj, [])
    ).

lca(U, V, LCA_Table) ->
    Depth = maps:get(depth, LCA_Table),
    Parent = maps:get(parent, LCA_Table),

    DU = array:get(U, Depth),
    DV = array:get(V, Depth),

    if DU < DV ->
        lca(V, U, LCA_Table);
    true ->
        pass
    end,

    while array:get(U, Depth) > array:get(V, Depth) do
        U = array:get(U, Parent)
    end,

    if U == V ->
        U;
    true ->
        while array:get(U, Parent) /= array:get(V, Parent) do
            U = array:get(U, Parent),
            V = array:get(V, Parent)
        end,
        array:get(U, Parent)
    end.

process_query(U, V, Threshold, Adj, LCA_Table) ->
    Ancestor = lca(U, V, LCA_Table),

    Path_U_Ancestor = get_path(U, Ancestor, Adj, maps:get(depth, LCA_Table), maps:get(parent, LCA_Table)),
    Path_V_Ancestor = get_path(V, Ancestor, Adj, maps:get(depth, LCA_Table), maps:get(parent, LCA_Table)),

    Counts = lists:foldl(
        fun(W, Acc) ->
            maps:update_with(W, fun(C) -> C + 1 end, 1, Acc)
        end,
        #{},
        Path_U_Ancestor ++ Path_V_Ancestor
    ),

    Max_Count = lists:foldl(
        fun({_W, Count}, Max) ->
            max(Max, Count)
        end,
        0,
        maps:to_list(Counts)
    ),

    if length(Path_U_Ancestor) + length(Path_V_Ancestor) + 1 - Max_Count <= Threshold ->
        true;
    true ->
        false
    end.

get_path(Start, End, Adj, Depth, Parent) ->
    Path = [],

    get_path_recursive(Start, End, Adj, Depth, Parent, Path).

get_path_recursive(Start, End, Adj, Depth, Parent, Path) ->
    if Start == End ->
        Path;
    true ->
        Parent_Node = array:get(Start, Parent),

        lists:foldl(
            fun({Neighbor, Weight}, Acc) ->
                if Neighbor == Parent_Node ->
                    [Weight | Acc];
                true ->
                    Acc
                end
            end,
            get_path_recursive(Parent_Node, End, Adj, Depth, Parent, Path),
            maps:get(Start, Adj, [])
        )
    end.