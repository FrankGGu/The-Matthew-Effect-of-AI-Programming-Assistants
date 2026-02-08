-module(solution).
-export([minimumCoins/1]).

-define(INF, 1_000_000_000_000_000_000). %% A sufficiently large number for infinity

build(Tree, NodeIdx, Low, High) ->
    if
        Low == High ->
            gb_array:set(NodeIdx, ?INF, Tree);
        true ->
            Mid = Low + (High - Low) div 2,
            Tree1 = build(Tree, 2 * NodeIdx, Low, Mid),
            Tree2 = build(Tree1, 2 * NodeIdx + 1, Mid + 1, High),
            gb_array:set(NodeIdx, ?INF, Tree2)
    end.

update(Tree, NodeIdx, Low, High, UpdateIdx, Val) ->
    if
        Low == High ->
            gb_array:set(NodeIdx, Val, Tree);
        true ->
            Mid = Low + (High - Low) div 2,
            NewTree = if
                UpdateIdx =< Mid ->
                    update(Tree, 2 * NodeIdx, Low, Mid, UpdateIdx, Val);
                true ->
                    update(Tree, 2 * NodeIdx + 1, Mid + 1, High, UpdateIdx, Val)
            end,
            LeftMin = gb_array:get(2 * NodeIdx, NewTree),
            RightMin = gb_array:get(2 * NodeIdx + 1, NewTree),
            gb_array:set(NodeIdx, min(LeftMin, RightMin), NewTree)
    end.

query(Tree, NodeIdx, Low, High, QueryLow, QueryHigh) ->
    %% If the current node's range is completely outside the query range
    if
        High < QueryLow; Low > QueryHigh ->
            ?INF;
        %% If the current node's range is completely inside the query range
        QueryLow =< Low andalso High =< QueryHigh ->
            gb_array:get(NodeIdx, Tree);
        true ->
            %% Partially overlapping, recurse
            Mid = Low + (High - Low) div 2,
            LeftMin = query(Tree, 2 * NodeIdx, Low, Mid, QueryLow, QueryHigh),
            RightMin = query(Tree, 2 * NodeIdx + 1, Mid + 1, High, QueryLow, QueryHigh),
            min(LeftMin, RightMin)
    end.

minimumCoins(Prices) ->
    N = length(Prices),

    %% Convert Prices list to an array for O(1) access
    PricesArray = array:from_list(Prices),

    %% The segment tree will cover indices from 0 to N.
    %% dp[N] is the base case.
    SegTreeMaxIdx = N,

    %% Max size for segment tree array is 4 * (SegTreeMaxIdx + 1) for 1-based indexing.
    Tree = gb_array:new(4 * (SegTreeMaxIdx + 1), {default, ?INF}), 

    %% Initialize segment tree with infinity
    InitialTree = build(Tree, 1, 0, SegTreeMaxIdx),

    %% Set dp[N] = 0 in the segment tree (base case: cost to buy fruits from N to N-1 is 0)
    UpdatedTree = update(InitialTree, 1, 0, SegTreeMaxIdx, N, 0),

    %% Iterate i from N-1 down to 0
    ResultTree = lists:foldr(
        fun(I, CurrentTree) ->
            PriceI = array:get(I, PricesArray), %% PricesArray is 0-indexed

            %% Calculate query range for dp values
            %% The range is [i+1, min(N, 2*i+3)] for dp values.
            QueryLow = I + 1,
            QueryHigh = min(N, 2 * I + 3),

            MinNextCost = query(CurrentTree, 1, 0, SegTreeMaxIdx, QueryLow, QueryHigh),

            CurrentDp = PriceI + MinNextCost,

            %% Update segment tree with dp[I]
            update(CurrentTree, 1, 0, SegTreeMaxIdx, I, CurrentDp)
        end,
        UpdatedTree,
        lists:seq(N - 1, 0, -1)
    ),

    %% The final answer is dp[0], which is stored in the segment tree at index 0.
    query(ResultTree, 1, 0, SegTreeMaxIdx, 0, 0).