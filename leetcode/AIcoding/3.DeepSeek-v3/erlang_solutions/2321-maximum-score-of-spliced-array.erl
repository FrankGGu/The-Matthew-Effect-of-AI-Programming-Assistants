-spec maximums_spliced_array(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
maximums_spliced_array(Nums1, Nums2) ->
    Sum1 = lists:sum(Nums1),
    Sum2 = lists:sum(Nums2),
    Diffs1 = lists:zipwith(fun(X, Y) -> Y - X end, Nums1, Nums2),
    Diffs2 = lists:zipwith(fun(X, Y) -> X - Y end, Nums1, Nums2),
    MaxDiff1 = kadane(Diffs1),
    MaxDiff2 = kadane(Diffs2),
    max(Sum1 + MaxDiff1, Sum2 + MaxDiff2).

kadane(List) ->
    kadane(List, 0, 0).

kadane([], _, MaxSoFar) ->
    MaxSoFar;
kadane([H | T], CurrentMax, MaxSoFar) ->
    NewCurrent = max(H, CurrentMax + H),
    NewMax = max(NewCurrent, MaxSoFar),
    kadane(T, NewCurrent, NewMax).