-module(solution).
-export([subsetXORSum/1]).

subsetXORSum(Nums) ->
    solve(0, Nums).

solve(CurrentXORTotal, []) ->
    CurrentXORTotal;
solve(CurrentXORTotal, [H|T]) ->
    SumExcluding = solve(CurrentXORTotal, T),
    SumIncluding = solve(CurrentXORTotal bor H, T),
    SumExcluding + SumIncluding.