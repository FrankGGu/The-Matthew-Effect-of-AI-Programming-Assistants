-module(leetcode_2192).
-export([get_ancestors/1]).

get_ancestors(Edges) ->
    Nodes = lists:usort(lists:flatten(Edges)),
    Graph = build_graph(Nodes, Edges),
    Ancestors = lists:foldl(fun(Node, Acc) -> 
        {_, Parents} = lists:keyfind(Node, 1, Graph),
        ParentsList = get_all_parents(Parents, Graph),
        maps:put(Node, lists:usort(ParentsList), Acc)
    end, #{}, Nodes),
    lists:sort([{Node, lists:sort(maps:get(Node, Ancestors))} || Node <- Nodes]).

build_graph([], _) -> [];
build_graph([Node | Rest], Edges) ->
    Parents = [Src || {Src, Dst} <- Edges, Dst == Node],
    [{Node, Parents} | build_graph(Rest, Edges)].

get_all_parents([], _) -> [];
get_all_parents([Parent | Rest], Graph) ->
    ParentAncestors = get_all_parents(Parent, Graph),
    ParentAncestors ++ [Parent | get_all_parents(Rest, Graph)].

get_all_parents(Node, Graph) ->
    case lists:keyfind(Node, 1, Graph) of
        {Node, Parents} ->
            lists:foldl(fun(P, Acc) -> Acc ++ get_all_parents(P, Graph) ++ [P] end, [], Parents);
        false -> []
    end.