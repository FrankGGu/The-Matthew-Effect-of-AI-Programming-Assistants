-module(minimum_depth_of_binary_tree).
-export([minDepth/1]).

-record(tree, {val, left, right}).

minDepth(nil) -> 0;
minDepth(#tree{left=Left, right=Right, val=_}) ->
    case {Left, Right} of
        {nil, nil} -> 1;
        {nil, _} -> 1 + minDepth(Right);
        {_, nil} -> 1 + minDepth(Left);
        _ -> 1 + erlang:min(minDepth(Left), minDepth(Right))
    end.