%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec has_cycle(Head :: #list_node{} | null) -> boolean().
has_cycle(Head) ->
    has_cycle(Head, []).

has_cycle(null, _) -> false;
has_cycle(#list_node{next = Next}, Seen) when Next /= null ->
    if lists:member(Next, Seen) -> true;
       true -> has_cycle(Next, [Next | Seen])
    end.
