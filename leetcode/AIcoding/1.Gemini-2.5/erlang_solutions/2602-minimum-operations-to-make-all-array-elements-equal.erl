-module(solution).
-export([min_operations/2]).

min_operations(Nums, Target) ->
    Diffs = lists:zipwith(fun(N, T) -> T - N end, Nums, Target),

    {TotalOps, _} = lists:foldl(
        fun(CurrentDiff, {AccOps, PrevDiff}) ->
            Delta = CurrentDiff - PrevDiff,
            NewAccOps = AccOps + abs(Delta),
            {NewAccOps, CurrentDiff}
        end,
        {0, 0},
        Diffs
    ),
    TotalOps.