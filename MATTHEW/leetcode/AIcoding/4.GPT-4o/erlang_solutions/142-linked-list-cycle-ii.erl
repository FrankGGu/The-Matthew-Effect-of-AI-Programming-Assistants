%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec detect_cycle(Head :: #list_node{} | null) -> #list_node{} | null.
detect_cycle(Head) ->
    detect_cycle(Head, []).

detect_cycle(null, _) -> null;
detect_cycle(#list_node{next = Next} = Head, Seen) ->
    case lists:member(Head, Seen) of
        true -> Head;
        false -> detect_cycle(Next, [Head | Seen])
    end.
