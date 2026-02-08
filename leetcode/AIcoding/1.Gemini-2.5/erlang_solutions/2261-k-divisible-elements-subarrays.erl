-module(solution).
-export([distinct_subarrays/3]).

distinct_subarrays(Nums, K, P) ->
    FinalSet = generate_subarrays_and_filter(Nums, K, P, gb_sets:new()),
    gb_sets:size(FinalSet).

generate_subarrays_and_filter(RemainingNums, K, P, AccSet) ->
    case RemainingNums of
        [] -> AccSet;
        [_ | T] ->
            AccSet2 = generate_subarrays_from_start(RemainingNums, K, P, 0, [], AccSet),
            generate_subarrays_and_filter(T, K, P, AccSet2)
    end.

generate_subarrays_from_start(CurrentSuffix, K, P, CurrentDivisibleCount, CurrentReversedSubarray, AccSet) ->
    case CurrentSuffix of
        [] -> AccSet;
        [H | T] ->
            NewDivisibleCount = CurrentDivisibleCount + (if H rem P == 0 -> 1; true -> 0 end),
            NewReversedSubarray = [H | CurrentReversedSubarray],
            AccSet2 = if NewDivisibleCount =< K ->
                        gb_sets:add(lists:reverse(NewReversedSubarray), AccSet);
                      true ->
                        AccSet
                      end,
            generate_subarrays_from_start(T, K, P, NewDivisibleCount, NewReversedSubarray, AccSet2)
    end.