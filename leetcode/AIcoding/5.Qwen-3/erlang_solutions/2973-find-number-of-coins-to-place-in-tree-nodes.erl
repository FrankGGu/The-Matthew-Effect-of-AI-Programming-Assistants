-module(solution).
-export([find_number_of_coins/1]).

find_number_of_coins(Edges) ->
    Tree = build_tree(Edges),
    {_, Count} = dfs(Tree, 0),
    Count.

build_tree(Edges) ->
    Map = maps:new(),
    lists:foldl(fun({A,B}, Acc) ->
        AMap = maps:get(A, Acc, maps:new()),
        BMap = maps:get(B, Acc, maps:new()),
        maps:put(A, maps:put(B, true, AMap), maps:put(B, maps:put(A, true, BMap), Acc))
    end, Map, Edges).

dfs(Node, Parent) ->
    Children = maps:keys(maps:get(Node, maps:new())),
    Total = 0,
    Count = 0,
    lists:foldl(fun(Child, {TotalAcc, CountAcc}) ->
        if Child /= Parent ->
            {SubTotal, SubCount} = dfs(Child, Node),
            {TotalAcc + SubTotal, CountAcc + SubCount};
        true -> {TotalAcc, CountAcc}
        end
    end, {0, 0}, Children).