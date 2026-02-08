%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec generate_trees(N :: integer()) -> [#tree_node{} | null].
generate_trees(N) when N == 0 -> [];
generate_trees(N) -> generate_trees(1, N).

-spec generate_trees(Start :: integer(), End :: integer()) -> [#tree_node{} | null].
generate_trees(Start, End) when Start > End -> [null];
generate_trees(Start, End) ->
    lists:flatten(
        lists:map(fun(Root) ->
            Left = generate_trees(Start, Root - 1),
            Right = generate_trees(Root + 1, End),
            generate_nodes(Root, Left, Right)
        end, lists:seq(Start, End))
    ).

-spec generate_nodes(RootVal :: integer(), Left :: [#tree_node{} | null], Right :: [#tree_node{} | null]) -> [#tree_node{} | null].
generate_nodes(RootVal, Left, Right) ->
    lists:flatmap(fun(L) ->
        lists:map(fun(R) ->
            #tree_node{val = RootVal, left = L, right = R}
        end, Right)
    end, Left).
