-module(palindrome_linked_list).
-export([is_palindrome/1]).

-record(list_node, {val, next}).

is_palindrome(undefined) -> true;
is_palindrome(Head) ->
    {Mid, _} = split(Head, Head),
    Reversed = reverse(Mid),
    compare(Head, Reversed).

split(Slow, Fast) ->
    case Fast of
        undefined -> {Slow, true};
        _ ->
            case Fast#list_node.next of
                undefined -> {Slow, true};
                _ ->
                    split(Slow#list_node.next, Fast#list_node.next#list_node.next)
            end
    end.

reverse(undefined) -> undefined;
reverse(Head) ->
    reverse(Head, undefined).

reverse(undefined, Acc) -> Acc;
reverse(Head, Acc) ->
    reverse(Head#list_node.next, #list_node{val = Head#list_node.val, next = Acc}).

compare(undefined, undefined) -> true;
compare(undefined, _) -> false;
compare(_, undefined) -> false;
compare(A, B) ->
    A#list_node.val == B#list_node.val andalso compare(A#list_node.next, B#list_node.next).