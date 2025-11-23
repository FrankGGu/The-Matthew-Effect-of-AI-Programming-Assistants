-module(solution).
-export([count_complete_components/1]).

count_complete_components(Edges) ->
    Nodes = lists:usort(lists:flatten(Edges)),
    Graph = build_graph(Nodes, Edges),
    Count = 0,
    lists:foldl(fun(Node, Acc) -> 
        case is_complete_component(Node, Graph, []) of
            true -> Acc + 1;
            false -> Acc
        end
    end, Count, Nodes).

build_graph([], _) -> [];
build_graph([Node | Rest], Edges) ->
    Neighbors = get_neighbors(Node, Edges),
    [{Node, Neighbors} | build_graph(Rest, Edges)].

get_neighbors(Node, []) -> [];
get_neighbors(Node, [H | T]) ->
    if
        hd(H) == Node -> [hd(T) | get_neighbors(Node, T)];
        hd(T) == Node -> [hd(H) | get_neighbors(Node, T)];
        true -> get_neighbors(Node, T)
    end.

is_complete_component(Node, Graph, Visited) ->
    case lists:keymember(Node, 1, Graph) of
        false -> false;
        true ->
            {_, Neighbors} = lists:keyfind(Node, 1, Graph),
            case lists:member(Node, Visited) of
                true -> true;
                false ->
                    NewVisited = [Node | Visited],
                    IsComplete = is_complete(Neighbors, Graph),
                    case IsComplete of
                        true ->
                            lists:all(fun(N) -> is_complete_component(N, Graph, NewVisited) end, Neighbors);
                        false -> false
                    end
            end
    end.

is_complete([], _) -> true;
is_complete([N | Rest], Graph) ->
    case lists:keymember(N, 1, Graph) of
        false -> false;
        true ->
            {_, NNeighbors} = lists:keyfind(N, 1, Graph),
            lists:sort(NNeighbors) == lists:sort(lists:delete(N, lists:flatten(Graph))),
            is_complete(Rest, Graph)
    end.