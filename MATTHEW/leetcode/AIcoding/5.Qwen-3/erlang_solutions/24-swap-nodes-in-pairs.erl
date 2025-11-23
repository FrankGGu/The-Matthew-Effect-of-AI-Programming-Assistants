-module(swap_nodes_in_pairs).
-export([swapPairs/1]).

-type list_node() :: #{
    val := integer(),
    next := list_node() | nil
}.

-spec swapPairs(list_node()) -> list_node().
swapPairs(Head) ->
    swapPairs(Head, nil).

swapPairs(nil, _Prev) ->
    nil;
swapPairs(#{} = Node, Prev) ->
    Next = maps:get(next, Node),
    case Next of
        nil ->
            Node;
        _ ->
            NextNext = maps:get(next, Next),
            NewNode = maps:put(next, swapPairs(NextNext, Node), Node),
            maps:put(next, maps:get(next, NewNode), NewNode)
    end.