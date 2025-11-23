-module(remove_max_number_of_edges_to_keep_graph_fully_traversable).
-export([max_num_edges/2]).

max_num_edges(Edges, N) ->
    Parent = array:new(N, {default, 0}),
    UnionFind1 = union_find_new(Parent),
    UnionFind2 = union_find_new(Parent),
    Count = 0,
    lists:foreach(fun({Type, U, V}) ->
        case Type of
            1 -> ok;
            2 -> ok
        end,
        case Type of
            1 ->
                case union_find_find(UnionFind1, U-1, V-1) of
                    true -> ok;
                    false -> Count1 = Count + 1, Count = Count1
                end;
            2 ->
                case union_find_find(UnionFind2, U-1, V-1) of
                    true -> ok;
                    false -> Count2 = Count + 1, Count = Count2
                end
        end
    end, Edges),
    Count.

union_find_new(Parent) ->
    Parent.

union_find_find(Parent, X, Y) ->
    XRoot = find_root(Parent, X),
    YRoot = find_root(Parent, Y),
    if
        XRoot == YRoot -> true;
        true ->
            array:set(YRoot, XRoot, Parent),
            false
    end.

find_root(Parent, X) ->
    case array:get(X, Parent) of
        X -> X;
        P -> find_root(Parent, P)
    end.