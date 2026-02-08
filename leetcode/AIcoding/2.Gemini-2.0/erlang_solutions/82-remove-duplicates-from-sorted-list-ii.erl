-module(remove_duplicates_sorted_list_ii).
-export([delete_duplicates/1]).

delete_duplicates(Head) ->
    delete_duplicates(Head, null).

delete_duplicates(null, _) ->
    null;
delete_duplicates(Head, Prev) ->
    case has_duplicates(Head) of
        true ->
            Val = Head#list_node.val,
            delete_duplicates(skip_duplicates(Head, Val), Prev);
        false ->
            NewHead = Head#list_node{next = delete_duplicates(Head#list_node.next, Head)},
            case Prev == null of
                true ->
                    NewHead;
                false ->
                    NewHead
            end
    end.

has_duplicates(null) ->
    false;
has_duplicates(Head) ->
    case Head#list_node.next == null of
        true ->
            false;
        false ->
            case Head#list_node.val == Head#list_node.next#list_node.val of
                true ->
                    true;
                false ->
                    false
            end
    end.

skip_duplicates(Head, Val) ->
    case Head == null of
        true ->
            null;
        false ->
            case Head#list_node.val == Val of
                true ->
                    skip_duplicates(Head#list_node.next, Val);
                false ->
                    Head
            end
    end.