-spec max_dot_product(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
max_dot_product(Nums1, Nums2) ->
    M = length(Nums1),
    N = length(Nums2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, -1000000)),
    DP1 = set_dp(1, 1, 0, DP),
    DP2 = fill_dp(1, 1, Nums1, Nums2, DP1),
    get_max(M, N, DP2).

set_dp(I, J, Val, DP) ->
    Row = lists:nth(I, DP),
    NewRow = setelement(J, list_to_tuple(Row), Val),
    setelement(I, list_to_tuple(DP), tuple_to_list(NewRow)).

get_dp(I, J, DP) ->
    Row = lists:nth(I, DP),
    element(J, list_to_tuple(Row)).

fill_dp(I, J, Nums1, Nums2, DP) when I > length(Nums1) ->
    DP;
fill_dp(I, J, Nums1, Nums2, DP) when J > length(Nums2) ->
    fill_dp(I + 1, 1, Nums1, Nums2, DP);
fill_dp(I, J, Nums1, Nums2, DP) ->
    A = lists:nth(I, Nums1),
    B = lists:nth(J, Nums2),
    Prev = get_dp(I - 1, J - 1, DP),
    Current = max(A * B, A * B + Prev),
    Up = get_dp(I - 1, J, DP),
    Left = get_dp(I, J - 1, DP),
    NewVal = max(Current, max(Up, Left)),
    NewDP = set_dp(I, J, NewVal, DP),
    fill_dp(I, J + 1, Nums1, Nums2, NewDP).

get_max(M, N, DP) ->
    get_dp(M, N, DP).