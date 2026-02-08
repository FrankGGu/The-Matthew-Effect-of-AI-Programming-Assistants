-spec max_distance(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
max_distance(Nums1, Nums2) ->
    MaxDistance = 0,
    I = 0,
    J = 0,
    Len1 = length(Nums1),
    Len2 = length(Nums2),
    max_distance(Nums1, Nums2, I, J, Len1, Len2, MaxDistance).

max_distance(Nums1, Nums2, I, J, Len1, Len2, MaxDistance) when I < Len1 andalso J < Len2 ->
    case lists:nth(I + 1, Nums1) =< lists:nth(J + 1, Nums2) of
        true ->
            NewMaxDistance = max(MaxDistance, J - I),
            max_distance(Nums1, Nums2, I, J + 1, Len1, Len2, NewMaxDistance);
        false ->
            max_distance(Nums1, Nums2, I + 1, J, Len1, Len2, MaxDistance)
    end;
max_distance(_, _, _, _, _, _, MaxDistance) ->
    MaxDistance.