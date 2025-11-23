-module(solution).
-export([frog_position/4]).

frog_position(N, Edges, T, Target) ->
    Graph = build_graph(N, Edges),
    dfs(Graph, 1, 0, 0, 1.0, Target, T).

build_graph(_N, Edges) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(L) -> [V|L] end, [V], Acc),
            maps:update_with(V, fun(L) -> [U|L] end, [U], Acc1)
        end,
        maps:new(),
        Edges
    ).

dfs(Graph, CurrentNode, Parent, CurrentTime, CurrentProb, Target, T) ->
    if CurrentTime > T ->
        0.0;
    true ->
        Neighbors = lists:delete(Parent, maps:get(CurrentNode, Graph, [])),
        NumJumps = length(Neighbors),

        if CurrentNode == Target ->
            if CurrentTime == T ->
                CurrentProb;
            else if NumJumps == 0 -> % Reached target early and stuck there
                CurrentProb;
            else -> % Reached target early but must jump away
                0.0
            end;
        else if CurrentTime == T -> % Not target, and time is up
            0.0;
        else if NumJumps == 0 -> % Not target, not T, and stuck. Cannot reach target.
            0.0;
        else -> % General recursive step
            ProbPerJump = CurrentProb / NumJumps,
            lists:sum([dfs(Graph, N, CurrentNode, CurrentTime + 1, ProbPerJump, Target, T) || N <- Neighbors])
        end
    end.