-module(minimum_edge_weight_equilibrium_queries_in_a_tree).
-export([equilibriumQueries/2]).

equilibriumQueries(Edges, Queries) ->
    N = length(Edges) + 1,
    Tree = build_tree(Edges, N),
    Results = lists:map(fun(Q) -> find_equilibrium(Tree, Q) end, Queries),
    Results.

build_tree([], _) -> [];
build_tree([{U, V, W} | Rest], N) ->
    Tree = build_tree(Rest, N),
    [ {U, V, W} | Tree ].

find_equilibrium(_, []) -> 0;
find_equilibrium(Tree, {U, V}) ->
    Total = get_total_weight(Tree),
    Left = get_subtree_weight(Tree, U, V),
    Right = Total - Left,
    abs(Left - Right).

get_total_weight(Tree) ->
    lists:sum([W || {_, _, W} <- Tree]).

get_subtree_weight(Tree, Start, Parent) ->
    lists:foldl(fun({U, V, W}, Acc) ->
        case (U == Start andalso V /= Parent) orelse (V == Start andalso U /= Parent) of
            true ->
                Sub = get_subtree_weight(Tree, if U == Start -> V; true -> U end, Start),
                Acc + W + Sub;
            false ->
                Acc
        end
    end, 0, Tree).