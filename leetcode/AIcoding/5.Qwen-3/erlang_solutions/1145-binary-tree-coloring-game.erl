-module(binary_tree_coloring_game).
-export([btree_game_won/1]).

-record(tree, {val, left, right}).

btree_game_won(Node) ->
    Count = count_nodes(Node),
    case count_nodes(Node#tree.left) of
        LeftCount when LeftCount > Count div 2 -> true;
        _ -> false
    end.

count_nodes(nil) -> 0;
count_nodes(Node) ->
    1 + count_nodes(Node#tree.left) + count_nodes(Node#tree.right).