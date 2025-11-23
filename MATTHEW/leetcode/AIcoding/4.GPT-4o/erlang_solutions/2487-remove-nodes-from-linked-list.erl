-module(solution).
-export([remove_nodes/1]).

-type list_node() :: {Value :: integer(), Next :: list_node() | none()}.

remove_nodes(Root) ->
    NewRoot = remove_nodes_helper(Root, -1),
    NewRoot.

remove_nodes_helper(none, _Max) -> none;
remove_nodes_helper({Value, Next}, Max) ->
    NewNext = remove_nodes_helper(Next, max(Value, Max)),
    if
        Value < Max -> NewNext;
        true -> {Value, NewNext}
    end.