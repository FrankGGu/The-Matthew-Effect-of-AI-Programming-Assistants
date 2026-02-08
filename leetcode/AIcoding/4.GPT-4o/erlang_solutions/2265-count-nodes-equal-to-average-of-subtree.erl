-module(solution).

-export([averageOfSubtree/1]).

-record(node, {val, left = null, right = null}).

averageOfSubtree(Root) ->
    count_nodes(Root).

count_nodes(null) ->
    {0, 0};
count_nodes(#node{val=Val, left=Left, right=Right}) ->
    {LeftCount, LeftSum} = count_nodes(Left),
    {RightCount, RightSum} = count_nodes(Right),
    TotalCount = LeftCount + RightCount + 1,
    TotalSum = LeftSum + RightSum + Val,
    Average = TotalSum div TotalCount,
    if
        Average == Val ->
            TotalCount;
        true ->
            0
    end + LeftCount + RightCount.