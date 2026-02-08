-module(solution).
-export([deleteMiddle/1]).

-record(list_node, {val, next}).

deleteMiddle(Head) ->
    N = count_nodes(Head, 0),
    case N of
        1 -> null;
        _ ->
            IndexToDelete = N div 2,
            delete_node_at_index(Head, IndexToDelete, 0)
    end.

count_nodes(null, Acc) -> Acc;
count_nodes(#list_node{next = Next}, Acc) ->
    count_nodes(Next, Acc + 1).

delete_node_at_index(null, _TargetIndex, _CurrentIndex) -> null;
delete_node_at_index(#list_node{val = Val, next = Next}, TargetIndex, CurrentIndex) ->
    case CurrentIndex of
        TargetIndex ->
            Next;
        _ ->
            #list_node{val = Val, next = delete_node_at_index(Next, TargetIndex, CurrentIndex + 1)}
    end.