-module(solution).
-export([countTriplets/1]).

countTriplets(Arr) ->
    N = length(Arr),
    PrefixXorList = build_prefix_xor_list(Arr),
    PrefixXorArray = array:from_list(PrefixXorList),
    count_loops(0, N, PrefixXorArray, 0).

build_prefix_xor_list(Arr) ->
    lists:reverse(lists:foldl(fun(X, Acc) -> [hd(Acc) bxor X | Acc] end, [0], Arr)).

count_loops(I, N, PrefixXorArray, CurrentCount) when I < N ->
    PI_Val = array:get(I, PrefixXorArray),
    NewCount = count_k_loop(I, I, N, PrefixXorArray, PI_Val, CurrentCount),
    count_loops(I+1, N, PrefixXorArray, NewCount);
count_loops(_I, _N, _PrefixXorArray, CurrentCount) ->
    CurrentCount.

count_k_loop(I, K, N, PrefixXorArray, PI_Val, CurrentCount) when K < N ->
    PK_plus_1_Val = array:get(K+1, PrefixXorArray),
    AddedCount = if
                     PI_Val == PK_plus_1_Val -> K - I;
                     true -> 0
                 end,
    count_k_loop(I, K+1, N, PrefixXorArray, PI_Val, CurrentCount + AddedCount);
count_k_loop(_I, _K, _N, _PrefixXorArray, _PI_Val, CurrentCount) ->
    CurrentCount.