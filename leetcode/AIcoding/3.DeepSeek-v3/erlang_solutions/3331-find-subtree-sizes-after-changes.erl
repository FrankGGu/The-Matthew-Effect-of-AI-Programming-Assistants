-module(solution).
-export([subtree_sizes_after_changes/2]).

subtree_sizes_after_changes(N, Edges) ->
    Tree = build_tree(N, Edges),
    {Size, _} = compute_sizes(0, -1, Tree),
    {_, Res} = compute_result(0, -1, Size, Tree, #{}),
    lists:map(fun(I) -> maps:get(I, Res) end, lists:seq(0, N-1)).

build_tree(N, Edges) ->
    Tree = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
                    array:set(V, [U | array:get(V, Acc1)], Acc1)
                end, Tree, Edges).

compute_sizes(Node, Parent, Tree) ->
    Children = lists:filter(fun(Child) -> Child =/= Parent end, array:get(Node, Tree)),
    {Sizes, Total} = lists:foldl(fun(Child, {SizesAcc, Sum}) ->
                                    {Size, NewSizes} = compute_sizes(Child, Node, Tree),
                                    {NewSizes, Sum + Size}
                                end, {#{}, 1}, Children),
    {Total, Sizes#{Node => Total}}.

compute_result(Node, Parent, TotalSize, Tree, SizeMap) ->
    Children = lists:filter(fun(Child) -> Child =/= Parent end, array:get(Node, Tree)),
    {ChildSizes, NewSizeMap} = lists:foldl(fun(Child, {Acc, Map}) ->
                                            {CSize, CMap} = compute_result(Child, Node, TotalSize, Tree, Map),
                                            {Acc#{Child => CSize}, CMap}
                                        end, {#{}, SizeMap}, Children),
    MySize = maps:get(Node, SizeMap),
    SumOther = TotalSize - MySize,
    NewSizeMap1 = lists:foldl(fun(Child, Map) ->
                                CSize = maps:get(Child, ChildSizes),
                                Map#{Child => SumOther + (MySize - CSize)}
                            end, NewSizeMap, Children),
    {MySize, NewSizeMap1#{Node => TotalSize}}.