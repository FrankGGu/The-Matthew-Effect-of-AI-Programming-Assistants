-module(solution).
-export([cycle_length_queries/1]).

cycle_length_queries(Queries) ->
    lists:map(fun({x, y}) -> cycle_length_query(x, y) end, Queries).

cycle_length_query(X, Y) ->
    DepthX = find_depth(X),
    DepthY = find_depth(Y),
    LCA = find_lca(X, Y),
    DepthX + DepthY - 2 * find_depth(LCA) + 1.

find_depth(X) ->
    Depth = find_depth_helper(X, 0),
    Depth.

find_depth_helper(0, Depth) -> Depth;
find_depth_helper(X, Depth) ->
    find_depth_helper((X - 1) div 2, Depth + 1).

find_lca(X, Y) ->
    while X /= Y do
        if X > Y -> X = (X - 1) div 2;
        else Y = (Y - 1) div 2
        end
    end,
    X.