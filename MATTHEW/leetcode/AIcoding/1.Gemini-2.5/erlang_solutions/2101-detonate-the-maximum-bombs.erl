-module(solution).
-export([maximumDetonations/1]).

maximumDetonations(Bombs) ->
    N = length(Bombs),
    BombsTuple = list_to_tuple(Bombs), % Convert to tuple for efficient random access

    AdjList = build_adj_list(BombsTuple, N),

    lists:foldl(fun(I, MaxAcc) ->
        % Start DFS from bomb I, adding I to the visited set initially
        InitialVisited = gb_sets:add(I, gb_sets:new()),
        FinalVisited = dfs(I, AdjList, InitialVisited),
        max(MaxAcc, gb_sets:size(FinalVisited))
    end, 0, lists:seq(0, N - 1)).

build_adj_list(BombsTuple, N) ->
    [build_adj_for_bomb(I, BombsTuple, N) || I <- lists:seq(0, N - 1)].

build_adj_for_bomb(I, BombsTuple, N) ->
    {Xi, Yi, Ri} = element(I + 1, BombsTuple), % Get bomb I's coordinates and radius
    Ri_sq = Ri * Ri, % Square of radius for distance comparison

    [J || J <- lists:seq(0, N - 1),
          I =/= J, % A bomb cannot detonate itself
          begin
              {Xj, Yj, _Rj} = element(J + 1, BombsTuple), % Get bomb J's coordinates
              Dx = Xi - Xj,
              Dy = Yi - Yj,
              DistSq = Dx*Dx + Dy*Dy, % Squared Euclidean distance
              DistSq =< Ri_sq % Check if bomb J is within bomb I's detonation range
          end].

dfs(CurrentBomb, AdjList, VisitedSet) ->
    % Get neighbors (bombs detonated by CurrentBomb)
    Neighbors = lists:nth(CurrentBomb + 1, AdjList), 

    % Recursively visit unvisited neighbors
    lists:foldl(fun(Neighbor, AccVisitedSet) ->
        if gb_sets:is_element(Neighbor, AccVisitedSet) ->
                AccVisitedSet; % Already visited, no action needed
           true ->
                % Add neighbor to visited set and recurse
                dfs(Neighbor, AdjList, gb_sets:add(Neighbor, AccVisitedSet))
        end
    end, VisitedSet, Neighbors).