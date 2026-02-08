-module(kth_ancestor_of_a_tree_node).
-export([kthAncestor/2]).

kthAncestor(Parents, K) ->
    N = length(Parents),
    Depth = array:new([{size, N}, {default, -1}]),
    build_depth(Parents, Depth, 0),
    lists:foldl(fun(I, Acc) -> find_kth(Acc, I, K, Parents, Depth) end, [], lists:seq(0, N-1)).

build_depth(_, _, N) when N >= length(Parents) -> ok;
build_depth(Parents, Depth, I) ->
    case array:get(I, Parents) of
        -1 -> array:set(I, 0, Depth);
        P ->
            D = array:get(P, Depth) + 1,
            array:set(I, D, Depth)
    end,
    build_depth(Parents, Depth, I+1).

find_kth(_, I, K, Parents, Depth) ->
    D = array:get(I, Depth),
    if D < K -> -1;
       true -> find_kth_parent(I, K, Parents, Depth)
    end.

find_kth_parent(I, K, Parents, Depth) ->
    case K of
        0 -> I;
        _ ->
            P = array:get(I, Parents),
            find_kth_parent(P, K-1, Parents, Depth)
    end.