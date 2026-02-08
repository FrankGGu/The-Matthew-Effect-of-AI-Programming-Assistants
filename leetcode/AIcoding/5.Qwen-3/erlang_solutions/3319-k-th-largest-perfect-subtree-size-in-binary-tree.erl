-module(solution).
-export([kth_largest/2]).

kth_largest(Root, K) ->
    {Sizes, _} = traverse(Root),
    Sorted = lists:sort(fun(A, B) -> B < A end, Sizes),
    lists:nth(K, Sorted).

traverse(nil) ->
    {[], 0};
traverse(#{} = Node) ->
    {LeftSizes, LeftSize} = traverse(Node#{}."left"),
    {RightSizes, RightSize} = traverse(Node#{}."right"),
    Size = LeftSize + RightSize + 1,
    {lists:append(LeftSizes, lists:append(RightSizes, [Size])), Size}.