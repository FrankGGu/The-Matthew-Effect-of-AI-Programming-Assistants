-module(solution).
-export([countSubarraysWithMedianK/2]).

get_diff(Num, K) when Num > K -> 1;
get_diff(Num, K) when Num < K -> -1;
get_diff(Num, K) when Num == K -> 0.

find_k_index_0_based([H|_T], K, Idx) when H == K -> Idx;
find_k_index_0_based([_H|T], K, Idx) -> find_k_index_0_based(T, K, Idx + 1).

calculate_left_balances_map(LeftSublist, K) ->
    {_FinalBalance, Map} = lists:foldl(fun(Num, {CurrentBalance, MapAcc}) ->
                                            NewBalance = CurrentBalance + get_diff(Num, K),
                                            NewMap = map:update_with(NewBalance, fun(V) -> V + 1 end, 1, MapAcc),
                                            {NewBalance, NewMap}
                                    end, {0, map:from_list([{0, 1}])}, lists:reverse(LeftSublist)),
    Map.

countSubarraysWithMedianK(Nums, K) ->
    K_idx = find_k_index_0_based(Nums, K, 0),
    N = length(Nums),

    LeftPart = lists:sublist(Nums, 1, K_idx),
    LeftBalances = calculate_left_balances_map(LeftPart, K),

    RightPart = lists:sublist(Nums, K_idx + 1, N - K_idx),

    {_FinalBalance, TotalCount} = lists:foldl(fun(Num, {AccBalance, AccCount}) ->
                                                NewBalance = AccBalance + get_diff(Num, K),
                                                CountForBalance0 = map:get(-NewBalance, LeftBalances, 0),
                                                CountForBalance1 = map:get(1 - NewBalance, LeftBalances, 0),
                                                {NewBalance, AccCount + CountForBalance0 + CountForBalance1}
                                        end, {0, 0}, RightPart),
    TotalCount.