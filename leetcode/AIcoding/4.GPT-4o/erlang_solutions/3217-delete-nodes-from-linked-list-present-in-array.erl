-module(solution).
-export([delete_nodes/2]).

-type node() :: {Value, Next :: node() | none}.
-type list() :: node() | none.

delete_nodes(List, To_delete) ->
    To_delete_set = sets:from_list(To_delete),
    delete_nodes_helper(List, To_delete_set).

delete_nodes_helper(List, To_delete_set) ->
    case List of
        none -> none;
        {Value, Next} ->
            if 
                sets:is_element(Value, To_delete_set) ->
                    delete_nodes_helper(Next, To_delete_set);
                true ->
                    {Value, delete_nodes_helper(Next, To_delete_set)}
            end
    end.