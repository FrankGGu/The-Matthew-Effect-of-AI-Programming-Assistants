-module(vertical_order_traversal).
-export([vertical_traversal/1]).

vertical_traversal(Root) ->
    {Nodes, MinCol, MaxCol} = collect_nodes(Root, 0, 0, []),
    lists:foldl(fun(Col, Acc) ->
        lists:foldl(fun({C, R, V}, Acc2) ->
            if C == Col then
                [V|Acc2]
            else
                Acc2
            end
        end, Acc, Nodes)
    end, [], lists:seq(MinCol, MaxCol)).

collect_nodes(null, _, _, Acc) ->
    {Acc, 0, 0};
collect_nodes(TreeNode, Row, Col, Acc) ->
    {Val, Left, Right} = TreeNode,
    {LeftNodes, MinLeft, MaxLeft} = collect_nodes(Left, Row + 1, Col - 1, Acc),
    {RightNodes, MinRight, MaxRight} = collect_nodes(Right, Row + 1, Col + 1, LeftNodes),
    NewNodes = [{Col, Row, Val}|RightNodes],
    MinCol = min(Col, min(MinLeft, MinRight)),
    MaxCol = max(Col, max(MaxLeft, MaxRight)),
    {lists:sort(fun({C1, R1, V1}, {C2, R2, V2}) ->
                     if C1 < C2 then
                         true
                     else if C1 > C2 then
                         false
                     else if R1 < R2 then
                         true
                     else
                         V1 < V2
                     end
                 end, NewNodes), MinCol, MaxCol}.