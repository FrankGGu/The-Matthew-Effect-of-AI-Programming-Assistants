-spec find_length(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
find_length(Nums1, Nums2) ->
    M = length(Nums1),
    N = length(Nums2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    Max = 0,
    {Result, _} = lists:foldl(fun(I, {AccMax, DPAcc}) ->
        lists:foldl(fun(J, {InnerMax, InnerDP}) ->
            case I > 0 andalso J > 0 andalso lists:nth(I, Nums1) =:= lists:nth(J, Nums2) of
                true ->
                    NewVal = 1 + lists:nth(J, lists:nth(I, InnerDP)),
                    NewDP = update_dp(InnerDP, I + 1, J + 1, NewVal),
                    {max(InnerMax, NewVal), NewDP};
                false ->
                    {InnerMax, InnerDP}
            end
        end, {AccMax, DPAcc}, lists:seq(1, N))
    end, {Max, DP}, lists:seq(1, M)),
    Result.

update_dp(DP, I, J, Val) ->
    Row = lists:nth(I, DP),
    NewRow = set_nth(J, Val, Row),
    set_nth(I, NewRow, DP).

set_nth(1, Val, [_ | T]) -> [Val | T];
set_nth(N, Val, [H | T]) -> [H | set_nth(N - 1, Val, T)].