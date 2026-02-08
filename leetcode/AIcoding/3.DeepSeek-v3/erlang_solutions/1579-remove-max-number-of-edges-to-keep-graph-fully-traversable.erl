-module(solution).
-export([max_num_edges_to_remove/2]).

max_num_edges_to_remove(N, Edges) ->
    {Type3, Others} = lists:partition(fun([T, _, _]) -> T == 3 end, Edges),
    UnionFind1 = init_union_find(N),
    UnionFind2 = init_union_find(N),
    {UnionFind1a, UnionFind2a, Used} = process_type3(Type3, UnionFind1, UnionFind2, 0),
    {UnionFind1b, UnionFind2b, Used1} = process_others(Others, UnionFind1a, UnionFind2a, Used),
    case {is_fully_connected(UnionFind1b, N), is_fully_connected(UnionFind2b, N)} of
        {true, true} -> length(Edges) - Used1;
        _ -> -1
    end.

init_union_find(N) ->
    array:new([{size, N + 1}, {fixed, true}, {default, -1}]).

process_type3([], UF1, UF2, Used) ->
    {UF1, UF2, Used};
process_type3([[_, U, V] | Rest], UF1, UF2, Used) ->
    case {find(UF1, U), find(UF1, V)} of
        {RootU, RootV} when RootU == RootV ->
            process_type3(Rest, UF1, UF2, Used);
        {RootU, RootV} ->
            UF1a = union(UF1, RootU, RootV),
            UF2a = union(UF2, RootU, RootV),
            process_type3(Rest, UF1a, UF2a, Used + 1)
    end.

process_others([], UF1, UF2, Used) ->
    {UF1, UF2, Used};
process_others([[Type, U, V] | Rest], UF1, UF2, Used) ->
    case Type of
        1 ->
            case {find(UF1, U), find(UF1, V)} of
                {RootU, RootV} when RootU == RootV ->
                    process_others(Rest, UF1, UF2, Used);
                {RootU, RootV} ->
                    UF1a = union(UF1, RootU, RootV),
                    process_others(Rest, UF1a, UF2, Used + 1)
            end;
        2 ->
            case {find(UF2, U), find(UF2, V)} of
                {RootU, RootV} when RootU == RootV ->
                    process_others(Rest, UF1, UF2, Used);
                {RootU, RootV} ->
                    UF2a = union(UF2, RootU, RootV),
                    process_others(Rest, UF1, UF2a, Used + 1)
            end
    end.

find(UF, X) ->
    Parent = array:get(X, UF),
    if
        Parent < 0 -> X;
        true ->
            Root = find(UF, Parent),
            array:set(X, Root, UF),
            Root
    end.

union(UF, RootX, RootY) ->
    RankX = -array:get(RootX, UF),
    RankY = -array:get(RootY, UF),
    if
        RankX > RankY ->
            array:set(RootY, RootX, UF);
        RankX < RankY ->
            array:set(RootX, RootY, UF);
        true ->
            UF1 = array:set(RootY, RootX, UF),
            array:set(RootX, -(RankX + 1), UF1)
    end.

is_fully_connected(UF, N) ->
    Roots = lists:usort([find(UF, I) || I <- lists:seq(1, N)]),
    length(Roots) == 1.