-module(remove_nth_node_from_end_of_list).
-export([remove_nth_from_end/2]).

-record(list_node, {val, next}).

remove_nth_from_end(Head, N) ->
    {_, NewHead} = remove(Head, N),
    NewHead.

remove(Node, N) ->
    case Node of
        false ->
            {0, false};
        _ ->
            {Count, Next} = remove(Node#list_node.next, N),
            NewCount = Count + 1,
            if
                NewCount == N ->
                    {NewCount, Node#list_node.next};
                true ->
                    {NewCount, Node#list_node{next = Next}}
            end
    end.