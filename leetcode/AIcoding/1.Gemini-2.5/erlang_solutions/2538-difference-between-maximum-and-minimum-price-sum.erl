-module(solution).
-export([max_price_sum/3]).

dfs(U, Parent, Adj, Prices) ->
    Children = lists:delete(Parent, array:get(U, Adj)),

    %% Accumulate results from children
    %% MaxPathOverallFromChildren: max of MaxPathV from all children
    %% ChildPathContributions: list of abs(Prices[U] - Prices[V]) + MaxDownV
    {MaxPathOverallFromChildren, ChildPathContributions} = 
        lists:foldl(
            fun(V, {CurrentMaxPathOverallFromChildren, CurrentChildPathContributions}) ->
                {MaxDownV, MaxPathV} = dfs(V, U, Adj, Prices),
                EdgePathVal = abs(array:get(U, Prices) - array:get(V, Prices)) + MaxDownV,
                {max(CurrentMaxPathOverallFromChildren, MaxPathV), [EdgePathVal | CurrentChildPathContributions]}
            end,
            {0, []},
            Children
        ),

    %% Calculate MaxDownU (maximum path sum starting at U and going down one branch)
    MaxDownU = 
        case ChildPathContributions of
            [] -> 0;
            _ -> lists:max(ChildPathContributions)
        end,

    %% Calculate MaxPathAtU (maximum path sum passing through U, potentially combining two branches)
    MaxPathAtU = 
        case ChildPathContributions of
            [] -> 0;
            [_OnlyOne] -> MaxDownU; %% Only one child, max path through U is MaxDownU
            _ -> %% Two or more children, find two largest contributions
                SortedContributions = lists:sort(fun(A, B) -> A >= B end, ChildPathContributions),
                FirstLargest = lists:nth(1, SortedContributions),
                SecondLargest = lists:nth(2, SortedContributions),
                FirstLargest + SecondLargest
        end,

    %% The overall max path in the subtree rooted at U is max of:
    %% 1. Max paths found entirely within children's subtrees (MaxPathOverallFromChildren)
    %% 2. Max path passing through U (MaxPathAtU)
    MaxPathOverall = max(MaxPathOverallFromChildren, MaxPathAtU),

    {MaxDownU, MaxPathOverall}.

max_price_sum(N, Edges, PricesList) ->
    %% Build adjacency list
    Adj = array:new(N, {default, []}),
    Adj1 = lists:foldl(
        fun([U, V], CurrentAdj) ->
            array:set(U, [V | array:get(U, CurrentAdj)], CurrentAdj)
        end,
        Adj,
        Edges
    ),
    Adj2 = lists:foldl(
        fun([U, V], CurrentAdj) ->
            array:set(V, [U | array:get(V, CurrentAdj)], CurrentAdj)
        end,
        Adj1,
        Edges
    ),

    %% Convert PricesList to an array for O(1) access
    Prices = array:from_list(PricesList),

    %% Start DFS from node 0 (arbitrary root for a tree)
    %% -1 is used as a dummy parent for the root
    {_MaxDownRoot, FinalMaxPath} = dfs(0, -1, Adj2, Prices),
    FinalMaxPath.