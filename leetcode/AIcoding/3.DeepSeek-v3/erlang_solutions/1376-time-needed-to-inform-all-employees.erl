-module(solution).
-export([num_of_minutes/4]).

num_of_minutes(N, HeadID, Manager, InformTime) ->
    Tree = build_tree(N, Manager),
    dfs(HeadID, Tree, InformTime).

build_tree(N, Manager) ->
    Tree = maps:new(),
    build_tree(0, N, Manager, Tree).

build_tree(I, N, Manager, Tree) when I < N ->
    M = lists:nth(I + 1, Manager),
    case M of
        -1 -> build_tree(I + 1, N, Manager, Tree);
        _ ->
            Children = maps:get(M, Tree, []),
            NewTree = maps:put(M, [I | Children], Tree),
            build_tree(I + 1, N, Manager, NewTree)
    end;
build_tree(_, _, _, Tree) -> Tree.

dfs(Node, Tree, InformTime) ->
    Children = maps:get(Node, Tree, []),
    MaxChildTime = case Children of
        [] -> 0;
        _ ->
            lists:max([dfs(Child, Tree, InformTime) || Child <- Children])
    end,
    lists:nth(Node + 1, InformTime) + MaxChildTime.