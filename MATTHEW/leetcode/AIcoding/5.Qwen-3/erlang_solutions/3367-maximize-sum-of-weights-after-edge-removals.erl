-module(solution).
-export([max_sum_of_weights/1]).

max_sum_of_weights(Edges) ->
    Graph = build_graph(Edges),
    {Root, _} = find_root(Graph),
    dfs(Root, -1, Graph).

build_graph(Edges) ->
    lists:foldl(fun({U, V, W}, Acc) ->
        Acc#{U => [{V, W} | maps:get(U, Acc, [])], V => [{U, W} | maps:get(V, Acc, [])]}
    end, #{}, Edges).

find_root(Graph) ->
    find_root(maps:keys(Graph), 0, 0).

find_root([], _, Root) ->
    {Root, 0};
find_root([Node | Rest], Parent, Current) ->
    case maps:is_key(Node, Graph) of
        true ->
            Children = maps:get(Node, Graph),
            {NextParent, NextCurrent} = lists:foldl(fun({Child, _}, {P, C}) ->
                if Child /= Parent -> {Child, C + 1};
                   true -> {P, C}
                end
            end, {Parent, 0}, Children),
            find_root(Rest, NextParent, NextCurrent);
        false ->
            find_root(Rest, Parent, Current)
    end.

dfs(Node, Parent, Graph) ->
    lists:foldl(fun({Child, Weight}, Acc) ->
        if Child /= Parent ->
            Acc + dfs(Child, Node, Graph) + Weight;
           true ->
            Acc
        end
    end, 0, maps:get(Node, Graph)).