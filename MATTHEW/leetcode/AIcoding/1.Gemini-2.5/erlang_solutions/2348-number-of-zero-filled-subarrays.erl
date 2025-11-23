-module(solution).
-export([zeroFilledSubarrays/1]).

zeroFilledSubarrays(Nums) ->
    count_subarrays(Nums, 0, 0).

count_subarrays([], CurrentZeroCount, TotalCount) ->
    TotalCount + (CurrentZeroCount * (CurrentZeroCount + 1)) div 2;
count_subarrays([H | T], CurrentZeroCount, TotalCount) ->
    if
        H == 0 ->
            count_subarrays(T, CurrentZeroCount + 1, TotalCount);
        true ->
            NewTotalCount = TotalCount + (CurrentZeroCount * (CurrentZeroCount + 1)) div 2,
            count_subarrays(T, 0, NewTotalCount)
    end.