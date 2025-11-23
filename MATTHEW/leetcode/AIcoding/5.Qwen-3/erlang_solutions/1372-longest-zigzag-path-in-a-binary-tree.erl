-module(solution).
-export([longestZigZag/1]).

longestZigZag(Root) ->
    {Max, _} = traverse(Root),
    Max.

traverse(nil) ->
    {0, 0};
traverse(Node) ->
    {LeftMax, LeftDir} = traverse(Node#btree.left),
    {RightMax, RightDir} = traverse(Node#btree.right),
    CurrentLeft = if
        LeftDir == right -> LeftMax + 1;
        true -> 1
    end,
    CurrentRight = if
        RightDir == left -> RightMax + 1;
        true -> 1
    end,
    NewMax = max(LeftMax, RightMax),
    NewMax2 = max(NewMax, CurrentLeft),
    NewMax3 = max(NewMax2, CurrentRight),
    {NewMax3, left}.