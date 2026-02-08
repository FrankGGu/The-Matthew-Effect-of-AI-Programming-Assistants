-module(insertion_sort_list).
-export([insertionSortList/1]).

-record(list_node, {val, next}).

insertionSortList(Head) ->
    insert(Head, null).

insert(null, _) ->
    null;
insert(Current, Prev) ->
    case Prev of
        null ->
            insert(Current#list_node.next, Current);
        _ ->
            if
                Current#list_node.val < Prev#list_node.val ->
                    % 交换节点
                    Prev#list_node.next = Current#list_node.next,
                    Current#list_node.next = Prev,
                    insert(Current#list_node.next, Current);
                true ->
                    insert(Current#list_node.next, Current)
            end
    end.