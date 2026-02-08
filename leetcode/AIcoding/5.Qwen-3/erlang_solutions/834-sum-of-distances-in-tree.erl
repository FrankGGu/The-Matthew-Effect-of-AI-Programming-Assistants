-module(sum_of_distances_in_tree).
-export([sum_distance/1]).

sum_distance(Edges) ->
    N = length(Edges) + 1,
    Tree = build_tree(Edges, N),
    Distances = array:new(N, {default, 0}),
    Count = array:new(N, {default, 1}),
    dfs(0, -1, Tree, Distances, Count),
    dfs2(0, -1, Tree, Distances, Count),
    Distances.

build_tree([], _) -> [];
build_tree([[A,B] | T], N) ->
    Tree = build_tree(T, N),
    Tree1 = add_edge(Tree, A, B),
    add_edge(Tree1, B, A).

add_edge(Tree, A, B) ->
    array:set(A, [B | array:get(A, Tree)], Tree).

dfs(Node, Parent, Tree, Distances, Count) ->
    Children = array:get(Node, Tree),
    lists:foreach(
        fun(Child) ->
            if Child /= Parent ->
                dfs(Child, Node, Tree, Distances, Count),
                Count1 = array:set(Node, array:get(Node, Count) + array:get(Child, Count), Count),
                Distances1 = array:set(Node, array:get(Node, Distances) + array:get(Child, Distances) + array:get(Child, Count), Distances),
                Count = Count1,
                Distances = Distances1;
           true -> ok
        end
    ),
    {Distances, Count}.

dfs2(Node, Parent, Tree, Distances, Count) ->
    Children = array:get(Node, Tree),
    lists:foreach(
        fun(Child) ->
            if Child /= Parent ->
                NewCount = array:set(Child, array:get(Node, Count) - array:get(Child, Count) + array:get(Child, Count), Count),
                NewDistances = array:set(Child, array:get(Node, Distances) - array:get(Child, Count) + (array:get(Node, Count) - array:get(Child, Count)), Distances),
                dfs2(Child, Node, Tree, NewDistances, NewCount);
           true -> ok
        end
    ),
    Distances.