-module(solution).
-export([beautifulSubarrays/2]).

beautifulSubarrays(Nums, K) ->
    % The accumulator stores:
    % 1. Total count of beautiful subarrays found so far.
    % 2. Current count of odd numbers in the prefix ending at the current element.
    % 3. A map storing the frequency of prefix odd counts encountered so far.
    %    The map is initialized with #{0 => 1} to account for the empty prefix
    %    having 0 odd numbers, which is crucial for subarrays starting from index 0.
    {FinalCount, _, _} = lists:foldl(
        fun(Num, {Count, CurrentOddCount, FreqMap}) ->
            % Determine if the current number is odd (1) or even (0)
            IsOdd = Num rem 2,

            % Update the current count of odd numbers in the prefix
            NewCurrentOddCount = CurrentOddCount + IsOdd,

            % We are looking for a previous prefix ending at index 'j-1' such that
            % (odd_count_up_to_current_index) - (odd_count_up_to_j-1) = K
            % This means (odd_count_up_to_j-1) = (odd_count_up_to_current_index) - K
            TargetOddCount = NewCurrentOddCount - K,

            % Find how many times 'TargetOddCount' has appeared as a prefix odd count
            % If it hasn't appeared, maps:get returns 0.
            CountToAdd = maps:get(TargetOddCount, FreqMap, 0),

            % Add this to the total count of beautiful subarrays
            NewCount = Count + CountToAdd,

            % Update the frequency map with the NewCurrentOddCount
            % If NewCurrentOddCount is already in the map, increment its value.
            % Otherwise, add it to the map with a value of 1.
            NewFreqMap = maps:update_with(NewCurrentOddCount, fun(Val) -> Val + 1 end, 1, FreqMap),

            {NewCount, NewCurrentOddCount, NewFreqMap}
        end,
        {0, 0, #{0 => 1}}, % Initial accumulator: {Count, CurrentOddCount, FreqMap}
        Nums
    ),
    FinalCount.