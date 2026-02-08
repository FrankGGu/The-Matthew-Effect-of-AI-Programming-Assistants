-module(solution).
-export([halveArray/1]).

halveArray(Nums) ->
    InitialSum = lists:sum(Nums),
    TargetSum = InitialSum / 2,
    Heap = lists:foldl(fun(N, AccHeap) -> gb_trees:insert(N, N, AccHeap) end, gb_trees:empty(), Nums),
    solve(InitialSum, TargetSum, 0, Heap).

solve(CurrentSum, TargetSum, Operations, Heap) when CurrentSum =< TargetSum ->
    Operations;
solve(CurrentSum, TargetSum, Operations, Heap) ->
    {MaxVal, _, NewHeap} = gb_trees:take_max(Heap),
    NewVal = MaxVal / 2,
    UpdatedSum = CurrentSum - (MaxVal - NewVal),
    UpdatedHeap = gb_trees:insert(NewVal, NewVal, NewHeap),
    solve(UpdatedSum, TargetSum, Operations + 1, UpdatedHeap).