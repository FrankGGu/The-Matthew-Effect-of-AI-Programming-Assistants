-module(solution).
-export([solve/1]).

solve(Tree) ->
    solve_helper(Tree, 0).

solve_helper(null, Acc) ->
    Acc;
solve_helper({node, Val, Left, Right}, Acc) ->
    solve_helper(Left, Acc + Val + solve_helper(Right, 0)).