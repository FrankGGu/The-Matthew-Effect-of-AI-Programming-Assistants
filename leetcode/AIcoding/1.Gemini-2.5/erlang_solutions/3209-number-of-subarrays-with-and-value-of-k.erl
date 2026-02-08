-module(solution).
-export([num_subarrays_with_and_value_k/2]).

num_subarrays_with_and_value_k(Nums, K) ->
    % Acc = #{total_count => integer(), current_and_counts => map()}
    % current_and_counts: Map from AND_value -> count of subarrays ending at the previous index with that AND_value
    FinalAcc = lists:foldl(
        fun(Num, Acc) ->
            TotalCount = maps:get(total_count, Acc),
            CurrentAndCounts = maps:get(current_and_counts, Acc),

            % Step 1: Create a new map for AND values of subarrays ending at the current 'Num'
            % by extending all subarrays from the previous index.
            ExtendedAndCounts = maps:fold(
                fun(PrevAndVal, PrevCount, TempMap) ->
                    NewAndVal = PrevAndVal band Num,
                    maps:update_with(NewAndVal, fun(V) -> V + PrevCount end, PrevCount, TempMap)
                end,
                maps:new(), % Start with an empty map for extended ANDs
                CurrentAndCounts
            ),

            % Step 2: Add the current 'Num' itself as a subarray ending at the current index.
            NewCurrentAndCounts = maps:update_with(Num, fun(V) -> V + 1 end, 1, ExtendedAndCounts),

            % Step 3: Update the total count if K is present in NewCurrentAndCounts.
            CountForK = maps:get(K, NewCurrentAndCounts, 0), % Get count for K, default 0 if not present

            % Return the updated accumulator
            #{total_count => TotalCount + CountForK, current_and_counts => NewCurrentAndCounts}
        end,
        #{total_count => 0, current_and_counts => maps:new()}, % Initial accumulator
        Nums
    ),
    maps:get(total_count, FinalAcc).