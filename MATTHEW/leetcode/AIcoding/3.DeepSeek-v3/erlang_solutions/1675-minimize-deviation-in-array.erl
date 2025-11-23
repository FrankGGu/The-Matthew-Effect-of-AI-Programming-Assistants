-spec minimum_deviation(Nums :: [integer()]) -> integer().
minimum_deviation(Nums) ->
    MaxHeap = lists:foldl(fun(Num, Heap) ->
        case Num rem 2 of
            1 -> gb_sets:add_element(2 * Num, Heap);
            0 -> gb_sets:add_element(Num, Heap)
        end
    end, gb_sets:new(), Nums),
    {Min, Max, Ans} = find_min_deviation(gb_sets:to_list(MaxHeap),
    Ans.

find_min_deviation(List) ->
    Sorted = lists:sort(List),
    Min = hd(Sorted),
    Max = lists:last(Sorted),
    Ans = Max - Min,
    find_min_deviation(Sorted, Min, Max, Ans).

find_min_deviation([H | T], Min, Max, Ans) ->
    case H rem 2 of
        0 ->
            NewH = H div 2,
            NewList = lists:sort([NewH | T]),
            NewMin = min(NewH, Min),
            NewMax = max(lists:last(NewList), NewH),
            NewAns = min(Ans, NewMax - NewMin),
            find_min_deviation(NewList, NewMin, NewMax, NewAns);
        1 ->
            Ans
    end;
find_min_deviation([], _, _, Ans) ->
    Ans.