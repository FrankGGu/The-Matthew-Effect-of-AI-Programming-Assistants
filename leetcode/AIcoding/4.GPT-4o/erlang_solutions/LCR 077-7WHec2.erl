-module(solution).
-export([sort_list/1]).

-record(node, {val, next}).

sort_list(List) ->
    SortedList = merge_sort(List),
    SortedList.

merge_sort(nil) -> 
    nil;
merge_sort(Head) ->
    {Left, Right} = split(Head),
    merge(merge_sort(Left), merge_sort(Right)).

split(nil) -> 
    {nil, nil};
split(Head) ->
    split_helper(Head, nil, nil).

split_helper(nil, Left, Right) -> 
    {Left, Right};
split_helper({Node=Node, Next=Next}, Left, Right) ->
    case Right of
        nil -> 
            split_helper(Next, {Node, Left}, {Node, Right});
        _ -> 
            split_helper(Next, {Node, Left}, Right)
    end.

merge(nil, Right) -> 
    Right;
merge(Left, nil) -> 
    Left;
merge({LeftNode=LeftNode, LeftNext=LeftNext}, {RightNode=RightNode, RightNext=RightNext}) ->
    if 
        LeftNode#node.val =< RightNode#node.val ->
            {LeftNode#node{next=merge(LeftNext, {RightNode, RightNext})}};
        true ->
            {RightNode#node{next=merge({LeftNode, LeftNext}, RightNext)}}
    end.