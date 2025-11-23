-spec kth_smallest_product(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> integer().
kth_smallest_product(Nums1, Nums2, K) ->
    {Min1, Max1} = {hd(Nums1), lists:last(Nums1)},
    {Min2, Max2} = {hd(Nums2), lists:last(Nums2)},
    Candidates = [Min1 * Min2, Min1 * Max2, Max1 * Min2, Max1 * Max2],
    {Left, Right} = {lists:min(Candidates), lists:max(Candidates)},
    binary_search(Nums1, Nums2, K, Left, Right).

binary_search(Nums1, Nums2, K, Left, Right) when Left < Right ->
    Mid = Left + (Right - Left) div 2,
    Count = count_less_or_equal(Nums1, Nums2, Mid),
    if
        Count < K -> binary_search(Nums1, Nums2, K, Mid + 1, Right);
        true -> binary_search(Nums1, Nums2, K, Left, Mid)
    end;
binary_search(_, _, _, Left, _) ->
    Left.

count_less_or_equal(Nums1, Nums2, Target) ->
    lists:sum([count_in_nums2(Nums2, Target div Num) || Num <- Nums1, Num /= 0]) +
    case Target >= 0 of
        true -> 
            ZeroCount1 = length([1 || Num <- Nums1, Num == 0]),
            ZeroCount2 = length([1 || Num <- Nums2, Num == 0]),
            ZeroCount1 * length(Nums2) + ZeroCount2 * length(Nums1) - ZeroCount1 * ZeroCount2;
        false -> 0
    end.

count_in_nums2(Nums2, Target) ->
    case Target >= 0 of
        true ->
            case lists:last(Nums2) =< Target of
                true -> length(Nums2);
                false ->
                    case hd(Nums2) > Target of
                        true -> 0;
                        false -> find_upper_bound(Nums2, Target, 1, length(Nums2))
                    end
            end;
        false ->
            case hd(Nums2) >= Target of
                true -> length(Nums2);
                false ->
                    case lists:last(Nums2) < Target of
                        true -> 0;
                        false -> find_lower_bound(Nums2, Target, 1, length(Nums2))
                    end
            end
    end.

find_upper_bound(Nums2, Target, Left, Right) ->
    case Left < Right of
        true ->
            Mid = Left + (Right - Left) div 2,
            case lists:nth(Mid, Nums2) =< Target of
                true -> find_upper_bound(Nums2, Target, Mid + 1, Right);
                false -> find_upper_bound(Nums2, Target, Left, Mid)
            end;
        false ->
            Left - 1
    end.

find_lower_bound(Nums2, Target, Left, Right) ->
    case Left < Right of
        true ->
            Mid = Left + (Right - Left) div 2,
            case lists:nth(Mid, Nums2) >= Target of
                true -> find_lower_bound(Nums2, Target, Left, Mid);
                false -> find_lower_bound(Nums2, Target, Mid + 1, Right)
            end;
        false ->
            Left - 1
    end.