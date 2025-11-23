-module(remove_duplicates_from_sorted_list).
-export([delete_duplicates/1]).

delete_duplicates(nil) -> nil;
delete_duplicates(#ListNode{val = Val, next = Next}) ->
    case Next of
        nil -> #ListNode{val = Val, next = nil};
        _ ->
            case Next#ListNode.val of
                Val -> delete_duplicates(Next);
                _ -> #ListNode{val = Val, next = delete_duplicates(Next)}
            end
    end.