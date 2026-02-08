-spec min_absolute_sum_diff(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
min_absolute_sum_diff(Nums1, Nums2) ->
    Sorted = lists:sort(Nums1),
    Sum = lists:foldl(fun({A, B}, Acc) -> Acc + abs(A - B) end, 0, lists:zip(Nums1, Nums2)),
    MaxReduction = lists:foldl(fun({A, B}, Max) ->
        Diff = abs(A - B),
        case binary_search(Sorted, B) of
            not_found -> Max;
            Closest ->
                NewDiff = abs(Closest - B),
                case Diff - NewDiff > Max of
                    true -> Diff - NewDiff;
                    false -> Max
                end
        end
    end, 0, lists:zip(Nums1, Nums2)),
    (Sum - MaxReduction) rem 1000000007.

binary_search(List, Target) ->
    binary_search(List, Target, 0, length(List) - 1, not_found).

binary_search(List, Target, Low, High, Best) when Low =< High ->
    Mid = (Low + High) div 2,
    MidVal = lists:nth(Mid + 1, List),
    if
        MidVal =:= Target -> MidVal;
        MidVal < Target ->
            NewBest = case Best of
                not_found -> MidVal;
                _ ->
                    if
                        abs(MidVal - Target) < abs(Best - Target) -> MidVal;
                        true -> Best
                    end
            end,
            binary_search(List, Target, Mid + 1, High, NewBest);
        true ->
            NewBest = case Best of
                not_found -> MidVal;
                _ ->
                    if
                        abs(MidVal - Target) < abs(Best - Target) -> MidVal;
                        true -> Best
                    end
            end,
            binary_search(List, Target, Low, Mid - 1, NewBest)
    end;
binary_search(_List, _Target, _Low, _High, Best) ->
    Best.