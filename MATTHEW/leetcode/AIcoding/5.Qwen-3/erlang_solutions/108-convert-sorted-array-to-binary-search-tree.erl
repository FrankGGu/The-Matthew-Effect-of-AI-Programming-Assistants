-module(solution).
-export([sorted_array_to_bst/1]).

-record(tn, {val, left, right}).

sorted_array_to_bst([]) ->
    null;
sorted_array_to_bst(Arr) ->
    len = length(Arr),
    build_tree(Arr, 0, len - 1).

build_tree(_, L, R) when L > R ->
    null;
build_tree(Arr, L, R) ->
    Mid = (L + R) div 2,
    #tn{
        val = lists:nth(Mid + 1, Arr),
        left = build_tree(Arr, L, Mid - 1),
        right = build_tree(Arr, Mid + 1, R)
    }.