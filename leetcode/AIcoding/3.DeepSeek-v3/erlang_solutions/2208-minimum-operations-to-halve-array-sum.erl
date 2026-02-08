-module(min_operations_to_halve_array_sum).
-export([halve_array/1]).

halve_array(Nums) ->
    Sum = lists:sum(Nums),
    Half = Sum / 2,
    MaxHeap = build_max_heap(Nums),
    halve_array(MaxHeap, Half, 0).

build_max_heap(Nums) ->
    Heap = gb_sets:empty(),
    lists:foldl(fun(Num, Acc) -> gb_sets:add_element(-Num, Acc) end, Heap, Nums).

halve_array(Heap, Target, Ops) ->
    case Target =< 0 of
        true -> Ops;
        false ->
            {Max, NewHeap} = gb_sets:take_largest(Heap),
            ActualMax = -Max,
            HalfMax = ActualMax / 2,
            NewTarget = Target - HalfMax,
            UpdatedHeap = gb_sets:add_element(-HalfMax, NewHeap),
            halve_array(UpdatedHeap, NewTarget, Ops + 1)
    end.