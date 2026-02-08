-module(solution).
-export([num_components/2]).

-record(node, {val, next}).

num_components(List, G) ->
    Components = sets:from_list(G),
    num_components(List, Components, 0, false).

num_components([], _, Count, _) ->
    Count;
num_components([H|T], Components, Count, InComponent) ->
    case sets:is_element(H, Components) of
        true ->
            if
                InComponent -> 
                    num_components(T, Components, Count, true);
                true -> 
                    num_components(T, Components, Count + 1, true)
            end;
        false ->
            num_components(T, Components, Count, false)
    end.