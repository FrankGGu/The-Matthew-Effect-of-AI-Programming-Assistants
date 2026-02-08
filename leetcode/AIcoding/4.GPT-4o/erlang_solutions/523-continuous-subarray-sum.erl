-module(solution).
-export([check_subarray_sum/2]).

-spec check_subarray_sum([integer()], integer()) -> boolean().
check_subarray_sum(Nums, K) ->
    check_subarray_sum(Nums, K, #{0 => -1}, 0, 0).

check_subarray_sum([], _, _, _) -> false;
check_subarray_sum([H | T], K, ModMap, Sum, Index) ->
    Sum2 = (Sum + H) rem K,
    case maps:find(Sum2, ModMap) of
        {ok, PrevIndex} when Index - PrevIndex > 1 -> true;
        _ -> check_subarray_sum(T, K, maps:put(Sum2, Index, ModMap), Sum2, Index + 1)
    end.
