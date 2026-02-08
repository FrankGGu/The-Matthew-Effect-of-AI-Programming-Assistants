-module(solution).
-export([is_even_odd_tree/1]).

-record(node, {val, left = nil, right = nil}).

is_even_odd_tree(Root) ->
    case is_even_odd_tree_helper(Root, 0, nil) of
        {ok, _} -> true;
        _ -> false
    end.

is_even_odd_tree_helper(nil, _, _) -> {ok, nil};
is_even_odd_tree_helper(Node, Level, Prev) ->
    Val = Node#node.val,
    case Level rem 2 of
        0 -> 
            if 
                Val rem 2 =:= 0, 
                Val > Prev -> 
                    is_even_odd_tree_helper(Node#node.left, Level + 1, Val),
                    is_even_odd_tree_helper(Node#node.right, Level + 1, Val);
                true -> 
                    {error, Val}
            end;
        1 -> 
            if 
                Val rem 2 =:= 1, 
                Val < Prev -> 
                    is_even_odd_tree_helper(Node#node.left, Level + 1, Val),
                    is_even_odd_tree_helper(Node#node.right, Level + 1, Val);
                true -> 
                    {error, Val}
            end
    end.