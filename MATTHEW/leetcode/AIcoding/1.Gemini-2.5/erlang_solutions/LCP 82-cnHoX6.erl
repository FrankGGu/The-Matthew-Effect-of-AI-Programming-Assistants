-module(solution).
-export([subsetXORSum/1]).

subsetXORSum(Nums) ->
    helper(Nums, 0).

helper([], CurrentXor) ->
    CurrentXor;
helper([H|T], CurrentXor) ->
    SumExclude = helper(T, CurrentXor),
    SumInclude = helper(T, CurrentXor bor H),
    SumExclude + SumInclude.