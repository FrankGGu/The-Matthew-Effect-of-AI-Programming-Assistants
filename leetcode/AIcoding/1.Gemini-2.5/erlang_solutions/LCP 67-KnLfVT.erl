-module(solution).
-export([decorateTree/1]).

-record(tree_node, {val, left, right}).

decorateTree(Root) ->
    {CostIfRootNotDecorated, CostIfRootIsDecorated} = dfs(Root),
    min(CostIfRootNotDecorated, CostIfRootIsDecorated).

dfs(nil) ->
    {0, infinity}.

dfs(#tree_node{val = Cost, left = Left, right = Right}) ->
    {L0, L1} = dfs(Left),
    {R0, R1} = dfs(Right),

    % CostIfNodeNotDecorated (C0):
    % If the current node is NOT decorated, then its children CANNOT be decorated.
    % This is because if a child were decorated, its parent (the current node) would have to be decorated,
    % which contradicts our assumption that the current node is not decorated.
    C0 = L0 + R0,

    % CostIfNodeIsDecorated (C1):
    % If the current node IS decorated, then its children can either be decorated or not.
    % We choose the option that yields the minimum cost for each child's subtree.
    C1 = Cost + min(L0, L1) + min(R0, R1),

    {C0, C1}.