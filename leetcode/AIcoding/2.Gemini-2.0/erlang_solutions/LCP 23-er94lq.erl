-module(magic_permutation).
-export([solve/1]).

solve(Nums) ->
    N = length(Nums),
    solve_helper(Nums, 0, N).

solve_helper(_, N, N) ->
    true;
solve_helper(Nums, Index, N) ->
    if
        Nums !! Index rem 2 == Index rem 2 ->
            solve_helper(Nums, Index + 1, N);
        true ->
            false
    end.