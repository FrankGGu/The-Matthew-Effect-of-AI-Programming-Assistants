-module(solution).
-export([count_sub_trees/2]).

count_sub_trees(N, Edges, Labels) ->
    Tree = build_tree(N, Edges),
    {Result, _} = dfs(0, -1, Labels, Tree),
    Result.

build_tree(N, Edges) ->
    Tree = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
                    array:set(V, [U | array:get(V, Acc1)], Acc1)
                end, Tree, Edges).

dfs(Node, Parent, Labels, Tree) ->
    Children = lists:filter(fun(Child) -> Child =/= Parent end, array:get(Node, Tree)),
    Count = maps:from_list([{lists:nth(Node + 1, Labels), 1}]),
    {NewCount, Result} = lists:foldl(fun(Child, {AccCount, AccResult}) ->
                                        {ChildCount, ChildResult} = dfs(Child, Node, Labels, Tree),
                                        MergedCount = maps:merge_with(fun(_, V1, V2) -> V1 + V2 end, AccCount, ChildCount),
                                        {MergedCount, ChildResult}
                                    end, {Count, array:new([{size, length(Labels)}, {default, 0}])}, Children),
    Result1 = array:set(Node, maps:get(lists:nth(Node + 1, Labels), NewCount, 0), Result),
    {Result1, NewCount}.