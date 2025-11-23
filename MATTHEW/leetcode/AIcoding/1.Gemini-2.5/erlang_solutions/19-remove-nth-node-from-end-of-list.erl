-module(solution).
-export([removeNthFromEnd/2]).

-record(list_node, {val, next}).

list_length(nil, Acc) -> Acc;
list_length(#list_node{next = Next}, Acc) -> list_length(Next, Acc + 1).

remove_at_index(nil, _) -> nil;
remove_at_index(#list_node{next = Next}, 0) -> Next; % Skip the current node
remove_at_index(#list_node{val = Val, next = Next}, K) when K > 0 ->
    NewNext = remove_at_index(Next, K - 1),
    #list_node{val = Val, next = NewNext}.

removeNthFromEnd(Head, N) ->
    case Head of
        nil -> nil;
        _ ->
            % First pass: Calculate the length of the list.
            L = list_length(Head, 0),
            % Calculate the 0-indexed position of the node to remove from the beginning.
            IndexToRemove = L - N,
            % Second pass: Remove the node at the calculated index.
            remove_at_index(Head, IndexToRemove)
    end.