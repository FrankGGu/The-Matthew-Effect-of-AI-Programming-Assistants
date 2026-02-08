-module(solution).
-export([construct_maximum_binary_tree/1]).

-record(node, {val, left = null, right = null}).

construct_maximum_binary_tree(List) ->
    case List of
        [] -> null;
        _ -> construct(List, 0, length(List) - 1)
    end.

construct(List, Left, Right) ->
    if
        Left > Right -> null;
        true ->
            MaxIndex = max_index(List, Left, Right),
            MaxValue = lists:nth(MaxIndex + 1, List),
            LeftNode = construct(List, Left, MaxIndex - 1),
            RightNode = construct(List, MaxIndex + 1, Right),
            #node{val = MaxValue, left = LeftNode, right = RightNode}
    end.

max_index(List, Left, Right) ->
    lists:foldl(fun(Index, {Max, MaxIdx}) ->
        case lists:nth(Index + 1, List) > Max of
            true -> {lists:nth(Index + 1, List), Index};
            false -> {Max, MaxIdx}
        end
    end, {0, Left}, lists:seq(Left, Right))#>1.