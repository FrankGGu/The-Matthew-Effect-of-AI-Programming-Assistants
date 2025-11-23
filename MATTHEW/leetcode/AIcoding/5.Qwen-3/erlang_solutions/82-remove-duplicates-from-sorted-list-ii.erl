-module(remove_duplicates_from_sorted_list_ii).
-export([delete_duplicates/1]).

-record(list_node, {val, next}).

delete_duplicates(nil) ->
    nil;
delete_duplicates(Node) ->
    {Head, _} = delete_duplicates_helper(Node, nil),
    Head.

delete_duplicates_helper(nil, _) ->
    {nil, nil};
delete_duplicates_helper(Current, Prev) ->
    Next = Current#list_node.next,
    case Next of
        nil ->
            if
                Prev == nil -> {Current, Current};
                true ->
                    if
                        Current#list_node.val == Prev#list_node.val ->
                            {nil, nil};
                        true ->
                            {Current, Current}
                    end
            end;
        _ ->
            if
                Current#list_node.val == Next#list_node.val ->
                    delete_duplicates_helper(Next, Current);
                true ->
                    if
                        Prev == nil ->
                            {Current, delete_duplicates_helper(Next, Current)};
                        Current#list_node.val == Prev#list_node.val ->
                            {nil, delete_duplicates_helper(Next, Current)};
                        true ->
                            {Current, delete_duplicates_helper(Next, Current)}
                    end
            end
    end.