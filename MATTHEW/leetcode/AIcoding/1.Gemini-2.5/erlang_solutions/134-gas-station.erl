-module(solution).
-export([canCompleteCircuit/2]).

canCompleteCircuit(Gas, Cost) ->
    N = length(Gas),
    IndexedZipped = lists:zip(lists:zip(Gas, Cost), lists:seq(0, N - 1)),

    Acc0 = {0, 0, 0}, % {TotalTank, CurrentTank, StartNode}

    {FinalTotalTank, _FinalCurrentTank, FinalStartNode} = lists:foldl(
        fun({{G, C}, Index}, {TotalTank, CurrentTank, StartNode}) ->
            Diff = G - C,
            NewTotalTank = TotalTank + Diff,
            NewCurrentTank = CurrentTank + Diff,
            if NewCurrentTank < 0 ->
                {NewTotalTank, 0, Index + 1};
               true ->
                {NewTotalTank, NewCurrentTank, StartNode}
            end
        end,
        Acc0,
        IndexedZipped
    ),

    if FinalTotalTank < 0 -> -1;
       true -> FinalStartNode
    end.