-module(properties_graph).
-export([has_path/2]).

has_path(Edges, Start) ->
    Graph = build_graph(Edges),
    visited(Start, Graph, sets:new()).

build_graph(Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc#{A => sets:add_element(B, maps:get(A, Acc, sets:new())),
             B => sets:add_element(A, maps:get(B, Acc, sets:new()))}
    end, #{}, Edges).

visited(Node, Graph, Visited) ->
    case maps:is_key(Node, Graph) of
        true ->
            lists:any(fun(Next) ->
                case sets:is_element(Next, Visited) of
                    false -> visited(Next, Graph, sets:add_element(Next, Visited));
                    true -> false
                end
            end, maps:get(Node, Graph));
        false ->
            false
    end.