-module(solution).
-export([min_cost/2]).

min_cost(N, Cuts) ->
    CutsSorted = lists:sort(Cuts),
    CutsWithEnds = [0 | CutsSorted] ++ [N],
    MinCost = min_cost_helper(CutsWithEnds, 0, length(CutsWithEnds) - 1, fun(_, _) -> 0 end),
    MinCost.

min_cost_helper(Cuts, L, R, Cost) ->
    if
        L + 1 >= R -> 
            0;
        true ->
            Min = lists:foldl(fun(X, Acc) -> 
                NewCost = Cost(L, R) + (Cuts(R) - Cuts(L)) + min_cost_helper(Cuts, L, X, Cost) + min_cost_helper(Cuts, X, R, Cost),
                min(Acc, NewCost)
            end, 1.0/0, lists:seq(L + 1, R - 1)),
            Min
    end.