-module(solution).
-export([find_subtree_sizes_after_changes/1]).

find_subtree_sizes_after_changes(Edges) ->
    N = length(Edges) + 1,
    Tree = build_tree(Edges, N),
    {Parent, Children} = build_parent_and_children(Tree, N),
    Sizes = array:new(N, {default, 0}),
    traverse(1, Parent, Children, Sizes),
    array:to_list(Sizes).

build_tree([], _) -> [];
build_tree([[U, V] | T], N) ->
    [{{U, V}, []} | build_tree(T, N)].

build_parent_and_children(Tree, N) ->
    Parent = array:new(N, {default, -1}),
    Children = array:new(N, {default, []}),
    build_parent_and_children_loop(Tree, Parent, Children, 1, N).

build_parent_and_children_loop([], Parent, Children, _, _) ->
    {Parent, Children};
build_parent_and_children_loop([{{U, V}, _} | T], Parent, Children, Index, N) ->
    if
        Index < N ->
            NewParent = array:set(U, V, Parent),
            NewChildren = array:set(V, [U | array:get(V, Children)], Children),
            build_parent_and_children_loop(T, NewParent, NewChildren, Index + 1, N);
        true ->
            build_parent_and_children_loop(T, Parent, Children, Index + 1, N)
    end.

traverse(Node, Parent, Children, Sizes) ->
    Size = 1,
    lists:foreach(fun(Child) -> traverse(Child, Parent, Children, Sizes) end, array:get(Node, Children)),
    ChildSizes = lists:map(fun(Child) -> array:get(Child, Sizes) end, array:get(Node, Children)),
    TotalSize = lists:sum(ChildSizes) + 1,
    array:set(Node, TotalSize, Sizes).