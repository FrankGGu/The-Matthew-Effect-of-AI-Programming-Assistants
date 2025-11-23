-module(solution).
-export([delete_nodes/2]).

delete_nodes(Head, Arr) ->
    Set = gb_sets:from_list(Arr),
    delete_nodes_recursive(Head, Set).

delete_nodes_recursive(nil, _Set) ->
    nil;
delete_nodes_recursive({Val, Next}, Set) ->
    case gb_sets:is_member(Val, Set) of
        true ->
            delete_nodes_recursive(Next, Set);
        false ->
            {Val, delete_nodes_recursive(Next, Set)}
    end.