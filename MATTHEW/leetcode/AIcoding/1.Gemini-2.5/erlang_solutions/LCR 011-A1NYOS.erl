-module(solution).
-export([find_max_length/1]).

find_max_length(Nums) ->
    % Initial state:
    % CurrentSum: The running sum (0s are -1, 1s are 1).
    % MaxLength: The maximum length found so far.
    % SumMap: A map storing {sum_value, first_occurrence_index}.
    %         Initialize with {0, -1} to handle subarrays starting from index 0.
    find_max_length_recursive(Nums, 0, 0, 0, #{0 => -1}).

find_max_length_recursive([], _Index, _CurrentSum, MaxLength, _SumMap) ->
    MaxLength;
find_max_length_recursive([H|T], Index, CurrentSum, MaxLength, SumMap) ->
    % Calculate the new sum based on the current element
    NewSum = CurrentSum + (case H of 0 -> -1; 1 -> 1 end),

    % Check if the NewSum has been seen before
    case maps:is_key(NewSum, SumMap) of
        true ->
            % If seen, a subarray with equal 0s and 1s exists between PrevIndex and Index.
            % Calculate its length and update MaxLength if it's greater.
            PrevIndex = maps:get(NewSum, SumMap),
            NewMaxLength = max(MaxLength, Index - PrevIndex),
            find_max_length_recursive(T, Index + 1, NewSum, NewMaxLength, SumMap);
        false ->
            % If not seen, store the current sum and its index in the map.
            NewSumMap = maps:put(NewSum, Index, SumMap),
            find_max_length_recursive(T, Index + 1, NewSum, MaxLength, NewSumMap)
    end.