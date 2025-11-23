-module(zero_array_transformation_iii).
-export([solve/1]).

solve(A) ->
    N = length(A),
    solve_helper(A, N, 0).

solve_helper([], 0, Count) ->
    Count;
solve_helper(A, N, Count) ->
    {Zeros, NonZeros} = lists:partition(fun(X) -> X == 0 end, A),
    NumZeros = length(Zeros),
    if NumZeros == N then
        Count
    else
        NextA = lists:map(fun(X) ->
            if X == 0 then
                0
            else
                0
            end
        end, A),
        solve_helper(NextA, N, Count + 1)
    end.