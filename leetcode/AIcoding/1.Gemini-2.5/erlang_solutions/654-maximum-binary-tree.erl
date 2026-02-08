-record(tree_node, {val, left, right}).

-export([construct_maximum_binary_tree/1]).

construct_maximum_binary_tree([]) ->
    nil;
construct_maximum_binary_tree(Nums) ->
    {MaxVal, MaxIdx} = find_max_and_index(Nums),

    {LeftFull, RightFull} = lists:split(MaxIdx, Nums),

    LeftSubarray = LeftFull,
    RightSubarray = tl(RightFull),

    LeftTree = construct_maximum_binary_tree(LeftSubarray),
    RightTree = construct_maximum_binary_tree(RightSubarray),
    #tree_node{val = MaxVal, left = LeftTree, right = RightTree}.

find_max_and_index([H|T]) ->
    find_max_and_index(T, H, 0, 1).

find_max_and_index([H|T], MaxVal, MaxIdx, CurrentIdx) when H > MaxVal ->
    find_max_and_index(T, H, CurrentIdx, CurrentIdx + 1);
find_max_and_index([_H|T], MaxVal, MaxIdx, CurrentIdx) ->
    find_max_and_index(T, MaxVal, MaxIdx, CurrentIdx + 1);
find_max_and_index([], MaxVal, MaxIdx, _CurrentIdx) ->
    {MaxVal, MaxIdx}.