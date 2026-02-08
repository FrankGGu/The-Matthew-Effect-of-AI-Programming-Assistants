-module(paint_grid).
-export([num_of_ways/1]).

num_of_ways(N) ->
    {A, B} = solve(N),
    (A + B) rem 1000000007.

solve(1) ->
    {12, 6};
solve(N) ->
    {A1, B1} = solve(N - 1),
    A = ((A1 * 3) rem 1000000007 + (B1 * 2) rem 1000000007) rem 1000000007,
    B = ((A1 * 2) rem 1000000007 + (B1 * 2) rem 1000000007) rem 1000000007,
    {A, B}.