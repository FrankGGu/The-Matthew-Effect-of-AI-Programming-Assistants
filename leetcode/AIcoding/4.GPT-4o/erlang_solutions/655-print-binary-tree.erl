-module(solution).
-export([print_tree/1]).

-record(node, {val, left = null, right = null}).

print_tree(Root) ->
    Width = tree_width(Root),
    Height = tree_height(Root),
    Rows = lists:duplicate(Height, lists:duplicate(Width, "")),
    fill_tree(Root, 0, 0, Width, Rows),
    lists:foreach(fun(Row) -> io:format("~s~n", [string:join(Row, " ")]) end, Rows).

fill_tree(null, _, _, _, _) -> ok;
fill_tree(Node, X, Y, Width, Rows) ->
    if
        X < length(Rows) andalso Y < Width ->
            Row = lists:nth(X + 1, Rows),
            NewRow = lists:replace(Y + 1, integer_to_list(Node#node.val), Row),
            Rows1 = lists:replace(X + 1, NewRow, Rows),
            fill_tree(Node#node.left, X + 1, Y - 1, Width, Rows1),
            fill_tree(Node#node.right, X + 1, Y + 1, Width, Rows1);
        true -> ok
    end.

tree_width(null) -> 0;
tree_width(Node) -> 2 * tree_height(Node) - 1.

tree_height(null) -> 0;
tree_height(Node) -> 1 + max(tree_height(Node#node.left), tree_height(Node#node.right)).