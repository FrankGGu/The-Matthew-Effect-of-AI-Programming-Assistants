-module(solution).
-export([min_time/3]).

min_time(N, Edges, HasApple) ->
    Adj = build_adj(N, Edges),
    HasAppleArray = array:from_list(HasApple),
    Result = dfs(0, -1, Adj, HasAppleArray),
    % The DFS function adds 2 for the edge connecting a node to its parent
    % if that path is relevant. For the root node (0), there is no parent edge,
    % so we subtract 2 from the final result if it's greater than 0.
    if Result > 0 -> Result - 2;
    true -> 0
    end.

build_adj(N, Edges) ->
    Adj = array:new([{size, N}, {default, []}]),
    lists:foldl(
        fun([U, V], CurrentAdj) ->
            AdjU = array:get(U, CurrentAdj),
            Adj1 = array:set(U, [V | AdjU], CurrentAdj),
            AdjV = array:get(V, Adj1),
            array:set(V, [U | AdjV], Adj1)
        end,
        Adj,
        Edges
    ).

dfs(U, Parent, Adj, HasAppleArray) ->
    Neighbors = array:get(U, Adj),

    TimeFromChildren = 0,
    HasAppleInAnyChildSubtree = false,

    {FinalTimeFromChildren, FinalHasAppleInAnyChildSubtree} = lists:foldl(
        fun(V, {CurrentTime, CurrentHasApple}) ->
            if V == Parent ->
                {CurrentTime, CurrentHasApple};
            true ->
                ChildPathTime = dfs(V, U, Adj, HasAppleArray),
                if ChildPathTime > 0 ->
                    {CurrentTime + ChildPathTime, true};
                true ->
                    {CurrentTime, CurrentHasApple}
                end
            end
        end,
        {TimeFromChildren, HasAppleInAnyChildSubtree},
        Neighbors
    ),

    HasAppleAtU = array:get(U, HasAppleArray),

    if HasAppleAtU or FinalHasAppleInAnyChildSubtree ->
        % If this node (U) has an apple, or any of its children's subtrees contain an apple,
        % then the path from its parent to U must be traversed. This adds 2 to the total time.
        % The time accumulated from children is already included in FinalTimeFromChildren.
        FinalTimeFromChildren + 2;
    true ->
        % If no apples in U's subtree and U itself doesn't have an apple,
        % this branch doesn't need to be visited.
        0
    end.