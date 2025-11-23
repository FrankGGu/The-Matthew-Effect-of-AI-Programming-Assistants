-module(sort_list).
-export([sort_list/1]).

-record(ListNode, {val, next}).

sort_list(undefined) ->
    undefined;
sort_list(List) ->
    sort_list(List, length(List)).

sort_list(Node, Length) when Length =< 1 ->
    Node;
sort_list(Node, Length) ->
    Mid = Length div 2,
    {Left, Right} = split(Node, Mid),
    LeftSorted = sort_list(Left, Mid),
    RightSorted = sort_list(Right, Length - Mid),
    merge(LeftSorted, RightSorted).

split(undefined, _) ->
    {undefined, undefined};
split(Node, 0) ->
    {undefined, Node};
split(Node, N) ->
    #ListNode{val = Val, next = Next} = Node,
    {Left, Right} = split(Next, N - 1),
    {#ListNode{val = Val, next = Left}, Right}.

merge(undefined, Right) ->
    Right;
merge(Left, undefined) ->
    Left;
merge(#ListNode{val = LVal, next = LNext}, #ListNode{val = RVal, next = RNext}) ->
    if
        LVal < RVal ->
            #ListNode{val = LVal, next = merge(LNext, #ListNode{val = RVal, next = RNext})};
        true ->
            #ListNode{val = RVal, next = merge(#ListNode{val = LVal, next = LNext}, RNext)}
    end.

length(undefined) ->
    0;
length(#ListNode{next = Next}) ->
    1 + length(Next).