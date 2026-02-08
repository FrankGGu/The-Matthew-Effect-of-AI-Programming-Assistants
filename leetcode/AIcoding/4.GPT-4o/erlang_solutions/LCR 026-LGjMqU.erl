-module(solution).
-export([reorder_list/1]).

-record(node, {val, next}).

reorder_list(Head) ->
    case Head of
        null -> null;
        _ ->
            {L1, L2} = split(Head),
            L2 = reverse(L2),
            merge(L1, L2)
    end.

split(Head) ->
    split(Head, Head, false, [], []).

split(null, null, _, L1, L2) -> {lists:reverse(L1), lists:reverse(L2)};
split(null, _Tail, true, L1, L2) -> {lists:reverse(L1), lists:reverse(L2)};
split(Node, Tail, true, L1, L2) ->
    split(Node#node.next, Tail#node.next, false, [Node#node.val | L1], L2);
split(Node, Tail, false, L1, L2) ->
    split(Node#node.next, Tail#node.next, true, L1, [Node#node.val | L2]).

merge([], L2) -> L2;
merge(L1, []) -> L1;
merge([H1 | T1], [H2 | T2]) ->
    [H1, H2 | merge(T1, T2)].

reverse(List) -> reverse(List, []).

reverse([], Acc) -> Acc;
reverse([H | T], Acc) -> reverse(T, [H | Acc]).