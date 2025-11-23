-module(reorder_list).
-export([reorder_list/1]).

-type list_node() :: #{} | nil.

-revision(1).

reorder_list(nil) -> nil;
reorder_list(Head) ->
    {Mid, Tail} = split(Head),
    Reversed = reverse(Tail),
    merge(Head, Reversed).

split(Head) ->
    split(Head, Head).

split(Head, Slow) ->
    case Head of
        nil -> {Slow, nil};
        _ ->
            case Head of
                #{} -> Next = maps:get(next, Head),
                       split(Next, maps:get(next, Slow))
            end
    end.

reverse(nil) -> nil;
reverse(Head) ->
    reverse(Head, nil).

reverse(nil, Acc) -> Acc;
reverse(Head, Acc) ->
    Next = maps:get(next, Head),
    maps:put(next, Acc, Head),
    reverse(Next, Head).

merge(A, B) ->
    merge(A, B, nil).

merge(nil, B, Acc) -> 
    if
        Acc == nil -> B;
        true -> append(Acc, B)
    end;
merge(A, nil, Acc) ->
    if
        Acc == nil -> A;
        true -> append(Acc, A)
    end;
merge(A, B, Acc) ->
    NextA = maps:get(next, A),
    maps:put(next, B, A),
    NextB = maps:get(next, B),
    maps:put(next, A, B),
    merge(NextA, NextB, B).

append(Acc, Node) ->
    case maps:get(next, Acc) of
        nil -> maps:put(next, Node, Acc);
        _ -> append(maps:get(next, Acc), Node)
    end.