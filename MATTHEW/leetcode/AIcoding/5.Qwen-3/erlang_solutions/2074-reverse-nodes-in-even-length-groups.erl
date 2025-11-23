-module(reverse_nodes_in_even_length_groups).
-export([reverseEvenLengthGroups/1]).

reverseEvenLengthGroups(Head) ->
    reverseEvenLengthGroups(Head, 1, []).

reverseEvenLengthGroups(null, _, Acc) ->
    lists:reverse(Acc);
reverseEvenLengthGroups(Head, K, Acc) ->
    List = get_k_nodes(Head, K),
    Len = length(List),
    if
        Len rem 2 == 0 ->
            reverseEvenLengthGroups(lists:nthtail(Len, Head), K + 1, [lists:reverse(List) | Acc]);
        true ->
            reverseEvenLengthGroups(lists:nthtail(Len, Head), K + 1, [List | Acc])
    end.

get_k_nodes(null, _) ->
    [];
get_k_nodes(Node, 0) ->
    [];
get_k_nodes(#node{val = Val, next = Next}, K) ->
    [Val | get_k_nodes(Next, K - 1)].