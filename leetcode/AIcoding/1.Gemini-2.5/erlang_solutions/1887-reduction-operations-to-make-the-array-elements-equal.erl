-module(solution).
-export([reduction_operations/1]).

reduction_operations(Nums) ->
    SortedNums = lists:sort(Nums),
    case SortedNums of
        [] -> 0;
        [_] -> 0;
        [H | T] ->
            {TotalOps, _, _} = lists:foldl(
                fun(CurrentNum, {AccOps, Steps, PrevNum}) ->
                    NewSteps = if CurrentNum > PrevNum -> Steps + 1;
                                  true -> Steps
                               end,
                    {AccOps + NewSteps, NewSteps, CurrentNum}
                end,
                {0, 0, H}, %% Initial accumulator: {TotalOperations, CurrentReductionSteps, PreviousElement}
                T
            ),
            TotalOps
    end.