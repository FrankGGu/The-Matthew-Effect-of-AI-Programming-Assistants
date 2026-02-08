-module(solution).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 0).

solve([], _, Result) ->
    Result;
solve([H | T], Index, Result) ->
    case H of
        0 -> solve(T, Index + 1, Result);
        _ -> solve(T, Index + 1, Result + math:pow(2, Index))
    end.