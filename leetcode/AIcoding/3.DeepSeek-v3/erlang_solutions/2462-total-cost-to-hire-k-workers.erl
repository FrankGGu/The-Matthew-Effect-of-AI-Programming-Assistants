-module(solution).
-export([total_cost/3]).

total_cost(Costs, K, Candidates) ->
    {LeftHeap, RightHeap} = split_heaps(Costs, Candidates),
    hire_workers(LeftHeap, RightHeap, K, 0).

split_heaps(Costs, Candidates) ->
    Len = length(Costs),
    if
        Len =< 2 * Candidates ->
            Left = lists:sublist(Costs, Candidates),
            Right = lists:nthtail(max(0, Len - Candidates), Costs),
            {heap:from_list(Left), heap:from_list(Right)};
        true ->
            Left = lists:sublist(Costs, Candidates),
            Right = lists:nthtail(Len - Candidates, Costs),
            Remaining = lists:sublist(Costs, Candidates + 1, Len - 2 * Candidates),
            {heap:from_list(Left), heap:from_list(Right), Remaining}
    end.

hire_workers(LeftHeap, RightHeap, 0, Total) -> Total;
hire_workers(LeftHeap, RightHeap, K, Total) ->
    LeftMin = case heap:is_empty(LeftHeap) of
                  true -> infinity;
                  false -> heap:min(LeftHeap)
              end,
    RightMin = case heap:is_empty(RightHeap) of
                   true -> infinity;
                   false -> heap:min(RightHeap)
               end,
    if
        LeftMin =< RightMin ->
            {Value, NewLeftHeap} = heap:take_min(LeftHeap),
            hire_workers(NewLeftHeap, RightHeap, K - 1, Total + Value);
        true ->
            {Value, NewRightHeap} = heap:take_min(RightHeap),
            hire_workers(LeftHeap, NewRightHeap, K - 1, Total + Value)
    end.