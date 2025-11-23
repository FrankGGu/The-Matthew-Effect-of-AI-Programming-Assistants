-module(maximum_genetic_difference_query).
-export([max_genetic_difference/2]).

max_genetic_difference(Parents, Queries) ->
    Tree = build_tree(Parents),
    solve(Tree, Queries).

build_tree(Parents) ->
    build_tree(Parents, 0, []).

build_tree([Parent | Rest], Index, Acc) ->
    case Parent of
        -1 ->
            build_tree(Rest, Index + 1, Acc);
        _ ->
            build_tree(Rest, Index + 1, lists:append(Acc, [{Parent, Index}]))
    end;
build_tree([], _, Acc) ->
    build_tree_helper(Acc, [], []).

build_tree_helper([], Acc, Roots) ->
    {lists:reverse(Roots), Acc};
build_tree_helper([{Parent, Child} | Rest], Acc, Roots) ->
    build_tree_helper(Rest, [{Parent, Child} | Acc], Roots);
build_tree_helper([], Acc, Roots) ->
    {lists:reverse(Roots), Acc}.

solve({Roots, Edges}, Queries) ->
    lists:map(fun(Query) -> solve_query(Roots, Edges, Query) end, Queries).

solve_query(Roots, Edges, {Node, Val}) ->
    Ancestors = get_ancestors(Roots, Edges, Node, []),
    find_max_xor(Ancestors, Val).

get_ancestors(Roots, Edges, Node, Acc) ->
    case get_parent(Edges, Node) of
        -1 ->
            lists:reverse([Node | Acc]);
        Parent ->
            get_ancestors(Roots, Edges, Parent, [Node | Acc])
    end.

get_parent(Edges, Node) ->
    get_parent(Edges, Node, -1).

get_parent([{Parent, Child} | _], Node, _) when Child == Node ->
    Parent;
get_parent([_ | Rest], Node, Acc) ->
    get_parent(Rest, Node, Acc);
get_parent([], _, Acc) ->
    Acc.

find_max_xor(Ancestors, Val) ->
    find_max_xor(Ancestors, Val, 0).

find_max_xor([Ancestor | Rest], Val, MaxXor) ->
    NewXor = Val bxor Ancestor,
    case NewXor > MaxXor of
        true ->
            find_max_xor(Rest, Val, NewXor);
        false ->
            find_max_xor(Rest, Val, MaxXor)
    end;
find_max_xor([], _, MaxXor) ->
    MaxXor.