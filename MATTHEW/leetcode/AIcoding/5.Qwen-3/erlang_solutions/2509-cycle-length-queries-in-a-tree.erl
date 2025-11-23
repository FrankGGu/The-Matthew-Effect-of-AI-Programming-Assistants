-module(cycle_length_queries_in_a_tree).
-export([cycleLengthQueries/1]).

cycleLengthQueries(Edges) ->
    Tree = build_tree(Edges),
    Results = lists:map(fun(Query) -> query_cycle_length(Tree, Query) end, edges_to_queries(Edges)),
    Results.

build_tree(Edges) ->
    Tree = gb_trees:empty(),
    build_tree(Edges, Tree).

build_tree([], Tree) ->
    Tree;
build_tree([[U, V] | Rest], Tree) ->
    Tree1 = insert_edge(U, V, Tree),
    Tree2 = insert_edge(V, U, Tree1),
    build_tree(Rest, Tree2).

insert_edge(Node, Child, Tree) ->
    case gb_trees:lookup(Node, Tree) of
        {value, Children} ->
            gb_trees:store(Node, [Child | Children], Tree);
        none ->
            gb_trees:store(Node, [Child], Tree)
    end.

edges_to_queries(Edges) ->
    lists:seq(1, length(Edges)).

query_cycle_length(Tree, Index) ->
    [U, V] = lists:nth(Index, edges_to_list(Edges)),
    LCA = find_lca(Tree, U, V),
    Depth = get_depth(Tree),
    DepthU = depth(Depth, U),
    DepthV = depth(Depth, V),
    DepthLCA = depth(Depth, LCA),
    DepthU + DepthV - 2 * DepthLCA.

edges_to_list(Edges) ->
    Edges.

get_depth(Tree) ->
    Depth = gb_trees:empty(),
    {_, Depth1} = dfs_depth(Tree, 1, 0, Depth),
    Depth1.

dfs_depth(Tree, Node, D, Depth) ->
    case gb_trees:lookup(Node, Tree) of
        {value, Children} ->
            NewDepth = gb_trees:store(Node, D, Depth),
            lists:foldl(fun(Child, Acc) ->
                            {_, Acc1} = dfs_depth(Tree, Child, D + 1, Acc),
                            Acc1
                        end, NewDepth, Children);
        none ->
            {Node, Depth}
    end.

depth(Depth, Node) ->
    case gb_trees:lookup(Node, Depth) of
        {value, D} -> D;
        none -> 0
    end.

find_lca(Tree, U, V) ->
    PathU = get_path(Tree, U),
    PathV = get_path(Tree, V),
    find_common_node(PathU, PathV).

get_path(Tree, Node) ->
    get_path(Tree, Node, []).

get_path(Tree, Node, Path) ->
    case gb_trees:lookup(Node, Tree) of
        {value, [Parent | _]} ->
            get_path(Tree, Parent, [Node | Path]);
        none ->
            [Node | Path]
    end.

find_common_node([], _) -> 0;
find_common_node(_, []) -> 0;
find_common_node([H | T1], [H | T2]) ->
    H;
find_common_node([_ | T1], [H | T2]) ->
    find_common_node(T1, T2).