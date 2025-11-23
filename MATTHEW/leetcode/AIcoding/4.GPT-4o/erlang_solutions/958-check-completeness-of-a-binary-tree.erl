-module(solution).
-export([is_complete_binary_tree/1]).

-record(node, {val, left = none, right = none}).

is_complete_binary_tree(Root) ->
    case count_nodes(Root) of
        -1 -> false;
        N -> is_complete(Root, 0, N)
    end.

count_nodes(none) -> 0;
count_nodes(#node{left=Left, right=Right}) ->
    1 + count_nodes(Left) + count_nodes(Right).

is_complete(none, _, _) -> true;
is_complete(#node{left=Left, right=Right}, Index, N) ->
    if
        Index >= N -> false;
        true -> is_complete(Left, 2 * Index + 1, N) andalso
                 is_complete(Right, 2 * Index + 2, N)
    end.