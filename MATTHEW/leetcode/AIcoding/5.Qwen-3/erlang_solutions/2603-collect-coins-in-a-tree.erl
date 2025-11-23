-module(collect_coins_in_a_tree).
-export([collect_coins/1]).

collect_coins(Root) ->
    collect_coins_helper(Root, 0).

collect_coins_helper(nil, _) ->
    0;
collect_coins_helper({node, Val, Left, Right}, Depth) ->
    LeftDepth = collect_coins_helper(Left, Depth + 1),
    RightDepth = collect_coins_helper(Right, Depth + 1),
    MaxDepth = max(LeftDepth, RightDepth),
    if
        Val == 1 andalso MaxDepth == 0 ->
            0;
        Val == 1 ->
            MaxDepth - Depth;
        true ->
            MaxDepth
    end.