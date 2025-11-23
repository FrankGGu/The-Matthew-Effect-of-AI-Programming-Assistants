-module(solution).
-export([max_performance/3]).

max_performance(N, Speed, Efficiency, K) ->
    Engineers = lists:zip(Efficiency, Speed),
    Sorted = lists:sort(fun({E1, _}, {E2, _}) -> E1 > E2 end, Engineers),
    {Max, Sum, Heap} = lists:foldl(fun({E, S}, {CurrentMax, CurrentSum, CurrentHeap}) ->
        NewSum = CurrentSum + S,
        case heap:size(CurrentHeap) < K of
            true ->
                NewHeap = heap:insert(S, CurrentHeap),
                NewMax = E * NewSum,
                {max(CurrentMax, NewMax), NewSum, NewHeap};
            false ->
                case S > heap:peek(CurrentHeap) of
                    true ->
                        {Min, Heap1} = heap:take(CurrentHeap),
                        NewSum1 = NewSum - Min,
                        NewHeap1 = heap:insert(S, Heap1),
                        NewMax1 = E * NewSum1,
                        {max(CurrentMax, NewMax1), NewSum1, NewHeap1};
                    false ->
                        NewMax2 = E * CurrentSum,
                        {max(CurrentMax, NewMax2), CurrentSum, CurrentHeap}
                end
        end
    end, {0, 0, heap:new(min)}, Sorted),
    Max rem 1000000007.