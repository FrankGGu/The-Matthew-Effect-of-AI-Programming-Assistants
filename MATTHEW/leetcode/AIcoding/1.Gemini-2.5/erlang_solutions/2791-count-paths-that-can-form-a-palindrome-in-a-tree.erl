-module(solution).
-export([countPaths/3]).

countPaths(N, ParentList, S) ->
    Adj = build_adj(N, ParentList),
    InitialCounts = #{0 => 1}, % Mask 0 (for virtual parent of root) has count 1
    dfs(0, 0, Adj, S, InitialCounts).

build_adj(N, ParentList) ->
    lists:foldl(fun(I, AccAdj) ->
        P = lists:nth(I + 1, ParentList), % ParentList is 0-indexed, so I+1 for 1-indexed list access
        maps:update_with(P, fun(L) -> [I | L] end, [I], AccAdj)
    end, maps:new(), lists:seq(1, N-1)).

dfs(U, CurrentMask, Adj, S, Counts) ->
    % S is 0-indexed string, Erlang string is 1-indexed list of char codes
    NodeChar = lists:nth(U + 1, S) - $0, % Get char code, convert to integer (0-9)
    NodeCharMask = 1 bsl NodeChar,
    NewMask = CurrentMask bxor NodeCharMask,

    % Paths (V, U) where M_U XOR M_{parent[V]} = 0
    Ans1 = maps:get(NewMask, Counts, 0),

    % Paths (V, U) where M_U XOR M_{parent[V]} = (1 << k)
    Ans2 = lists:foldl(fun(K, Acc) ->
        TargetMask = NewMask bxor (1 bsl K),
        Acc + maps:get(TargetMask, Counts, 0)
    end, 0, lists:seq(0, 9)),

    TotalAnsForU = Ans1 + Ans2,

    % Add NewMask to counts for children
    CountsAfterAdd = maps:update_with(NewMask, fun(V) -> V + 1 end, 1, Counts),

    Children = maps:get(U, Adj, []),
    ChildrenAns = lists:foldl(fun(V, Acc) ->
        Acc + dfs(V, NewMask, Adj, S, CountsAfterAdd)
    end, 0, Children),

    TotalAnsForU + ChildrenAns.