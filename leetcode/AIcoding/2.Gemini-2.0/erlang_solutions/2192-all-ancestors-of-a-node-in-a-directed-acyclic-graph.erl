-module(ancestors).
-export([get_ancestors/2]).

get_ancestors(N, Edges) ->
    Graph = create_graph(N, Edges),
    lists:sort([find_ancestors(Node, Graph) || Node <- lists:seq(0, N - 1)]).

create_graph(N, Edges) ->
    create_graph(Edges, lists:seq(0, N - 1), []).

create_graph([], _, Acc) ->
    Acc;
create_graph([{U, V} | Rest], Nodes, Acc) ->
    create_graph(Rest, Nodes, update_graph(U, V, Acc)).

update_graph(U, V, Graph) ->
    case lists:keyfind(U, 1, Graph) of
        false ->
            [{U, [V]} | Graph];
        {U, Neighbors} ->
            lists:keyreplace(U, 1, Graph, {U, [V | Neighbors]})
    end.

find_ancestors(Node, Graph) ->
    find_ancestors(Node, Graph, [], [Node], []).

find_ancestors(_Node, _Graph, Ancestors, [], Visited) ->
    {lists:sort(lists:usort(Ancestors)), Visited};
find_ancestors(Node, Graph, Ancestors, [Current | Queue], Visited) ->
    case lists:keyfind(Current, 1, Graph) of
        false ->
            find_ancestors(Node, Graph, Ancestors, Queue, [Current | Visited]);
        {Current, Neighbors} ->
            NewAncestors = Ancestors ++ [Current],
            NewQueue = Queue ++ lists:filter(fun(X) -> not lists:member(X, [Current | Visited]) end, Neighbors),
            find_ancestors(Node, Graph, NewAncestors, NewQueue, [Current | Visited])
    end.