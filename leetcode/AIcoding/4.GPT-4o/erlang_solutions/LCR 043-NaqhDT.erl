-module(complete_binary_tree_inserter).
-export([insert/2, new_node/1, new_tree/1]).

-record(node, {val, left = none, right = none}).

new_node(Value) ->
    #node{val = Value}.

new_tree(_) ->
    none.

insert(Tree, Value) ->
    case Tree of
        none -> new_node(Value);
        _ ->
            insert_helper(Tree, Value, false)
    end.

insert_helper(Tree, Value, IsLeft) ->
    case Tree of
        #node{left = Left, right = Right} when IsLeft =:= false ->
            case Left of
                none -> 
                    #node{Tree | left = new_node(Value)};
                _ -> 
                    insert_helper(Left, Value, true)
            end;
        #node{left = Left, right = Right} ->
            case Right of
                none -> 
                    #node{Tree | right = new_node(Value)};
                _ -> 
                    insert_helper(Right, Value, false)
            end
    end.