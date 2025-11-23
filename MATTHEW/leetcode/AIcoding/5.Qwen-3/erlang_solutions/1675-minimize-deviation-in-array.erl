-module(minimize_deviation_in_array).
-export([minimumDeviation/1]).

minimumDeviation(Nums) ->
    Sorted = lists:sort(Nums),
    MinHeap = lists:reverse(Sorted),
    {Min, Max} = lists:foldl(fun(X, {MinAcc, MaxAcc}) -> {min(X, MinAcc), max(X, MaxAcc)} end, {hd(Sorted), hd(Sorted)}, Sorted),
    State = {MinHeap, Min, Max},
    loop(State).

loop({Heap, Min, Max}) ->
    case Max - Min of
        0 -> Min;
        _ ->
            NextMax = lists:nth(1, Heap),
            if
                NextMax rem 2 == 0 ->
                    NewMax = NextMax * 2,
                    NewHeap = lists:delete(NextMax, Heap),
                    NewHeapSorted = lists:sort(NewHeap),
                    NewMin = min(Min, NewMax),
                    NewMaxVal = max(Max, NewMax),
                    loop({NewHeapSorted, NewMin, NewMaxVal});
                true ->
                    NewMax = NextMax,
                    NewHeap = lists:delete(NextMax, Heap),
                    NewHeapSorted = lists:sort(NewHeap),
                    NewMin = min(Min, NewMax),
                    NewMaxVal = max(Max, NewMax),
                    loop({NewHeapSorted, NewMin, NewMaxVal})
            end
    end.