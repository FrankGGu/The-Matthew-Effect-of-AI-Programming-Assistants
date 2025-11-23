-module(solution).
-export([getAllElements/2]).

getAllElements(Root1, Root2) ->
    List1 = lists:reverse(inorder_traversal_reverse(Root1, [])),
    List2 = lists:reverse(inorder_traversal_reverse(Root2, [])),
    merge_sorted_lists(List1, List2).

inorder_traversal_reverse(nil, Acc) ->
    Acc;
inorder_traversal_reverse({Val, Left, Right}, Acc) ->
    inorder_traversal_reverse(Left, [Val | inorder_traversal_reverse(Right, Acc)]).

merge_sorted_lists([], L2) ->
    L2;
merge_sorted_lists(L1, []) ->
    L1;
merge_sorted_lists([H1|T1], [H2|T2]) when H1 =< H2 ->
    [H1 | merge_sorted_lists(T1, [H2|T2])];
merge_sorted_lists([H1|T1], [H2|T2]) when H1 > H2 ->
    [H2 | merge_sorted_lists([H1|T1], T2)].