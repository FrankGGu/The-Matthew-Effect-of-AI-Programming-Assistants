-module(linked_list_components).
-export([count_components/1]).

-record(list_node, {val, next}).

count_components(Head) ->
    Nodes = get_nodes(Head),
    Set = sets:from_list(Nodes),
    count_components(Head, Set, 0).

get_nodes(null) -> [];
get_nodes(#list_node{val=Val, next=Next}) ->
    [Val | get_nodes(Next)].

count_components(null, _, Count) -> Count;
count_components(#list_node{val=Val, next=Next}, Set, Count) ->
    case sets:is_element(Val, Set) of
        true ->
            case sets:is_element(Next, Set) of
                true -> count_components(Next, Set, Count);
                false -> count_components(Next, Set, Count + 1)
            end;
        false -> count_components(Next, Set, Count)
    end.