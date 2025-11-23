-module(solution).
-export([k_length_apart/2]).

k_length_apart(Nums, K) ->
    check(Nums, K, 0, undefined).

check([], _, _, _) -> true;
check([1 | Rest], K, Index, PrevIndex) when PrevIndex =/= undefined ->
    if 
        Index - PrevIndex < K -> false;
        true -> check(Rest, K, Index + 1, Index)
    end;
check([0 | Rest], K, Index, PrevIndex) ->
    check(Rest, K, Index + 1, PrevIndex).