-module(solution).
-export([swapNodes/2]).

-record(node, {val, next}).

swapNodes(List, k) ->
    {First, Second} = get_nodes(List, k, 1, {undefined, undefined}),
    NewFirst = case First of
        undefined -> undefined;
        _ -> Second
    end,
    NewSecond = case Second of
        undefined -> undefined;
        _ -> First
    end,
    swap_helper(List, First, NewFirst, Second, NewSecond).

get_nodes(undefined, _, _, {First, Second}) -> 
    {First, Second};
get_nodes(#node{next=Next}=Node, k, Count, {First, Second}) ->
    NewFirst = if Count =:= k -> Node; true -> First end,
    NewSecond = if Count =:= (Count + 1 - k) -> Node; true -> Second end,
    get_nodes(Next, k, Count + 1, {NewFirst, NewSecond}).

swap_helper(undefined, _, _, _, _) -> 
    undefined;
swap_helper(#node{val=Val, next=Next}=Node, First, NewFirst, Second, NewSecond) ->
    NewNode = if Node =:= First -> NewFirst; Node =:= Second -> NewSecond; true -> Node end,
    NewNodeNext = swap_helper(Next, First, NewFirst, Second, NewSecond),
    #node{val=NewNode#node.val, next=NewNodeNext}.