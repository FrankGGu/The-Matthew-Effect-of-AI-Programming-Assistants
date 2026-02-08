-module(longest_univalue_path).
-export([longestUnivaluePath/1]).

-record(node, {val, left, right}).

longestUnivaluePath(Root) ->
    {_, Max} = longestUnivaluePathHelper(Root, 0),
    Max.

longestUnivaluePathHelper(null, Max) ->
    {0, Max};
longestUnivaluePathHelper(Node, Max) ->
    #node{val = Val, left = Left, right = Right} = Node,
    {LeftPath, LeftMax} = longestUnivaluePathHelper(Left, Max),
    {RightPath, RightMax} = longestUnivaluePathHelper(Right, LeftMax),
    NewMax = RightMax,
    LeftArrow = case Left of
        null -> 0;
        #node{val = LeftVal} ->
            if LeftVal == Val -> LeftPath + 1
            else 0
            end
    end,
    RightArrow = case Right of
        null -> 0;
        #node{val = RightVal} ->
            if RightVal == Val -> RightPath + 1
            else 0
            end
    end,
    NewPath = max(LeftArrow, RightArrow),
    NewMax2 = max(NewMax, LeftArrow + RightArrow),
    {NewPath, NewMax2}.