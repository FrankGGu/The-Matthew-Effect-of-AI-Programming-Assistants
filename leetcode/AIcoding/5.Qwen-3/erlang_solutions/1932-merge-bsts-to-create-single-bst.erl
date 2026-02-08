-module(merge_bsts_to_create_single_bst).
-export([merge_bsts/1]).

-record(bst, {value, left, right}).

merge_bsts(Bsts) ->
    merge_all(Bsts).

merge_all([]) ->
    null;
merge_all([H | T]) ->
    merge(merge_all(T), H).

merge(null, Bst) ->
    Bst;
merge(Bst1, Bst2) ->
    List1 = to_list(Bst1),
    List2 = to_list(Bst2),
    Merged = lists:usort(List1 ++ List2),
    build_bst(Merged).

to_list(null) ->
    [];
to_list(#bst{value = V, left = L, right = R}) ->
    to_list(L) ++ [V] ++ to_list(R).

build_bst([]) ->
    null;
build_bst([H | T]) ->
    Mid = length(T) div 2,
    Left = build_bst(lists:sublist(T, Mid)),
    Right = build_bst(lists:sublist(T, Mid + 1, length(T) - Mid - 1)),
    #bst{value = H, left = Left, right = Right}.