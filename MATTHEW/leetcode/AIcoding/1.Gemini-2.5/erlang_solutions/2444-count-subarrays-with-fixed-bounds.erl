-module(solution).
-export([countSubarraysWithFixedBounds/3]).

countSubarraysWithFixedBounds(Nums, MinK, MaxK) ->
    % Call a tail-recursive helper function to process the list.
    % Arguments:
    %   List: The remaining part of the input list.
    %   J: The current index of the element being processed.
    %   MinK: The required minimum value for subarrays.
    %   MaxK: The required maximum value for subarrays.
    %   Acc: A tuple representing the accumulated state:
    %        {TotalCount, LastBadIdx, LastMinKIdx, LastMaxKIdx}
    %        TotalCount: The count of valid subarrays found so far.
    %        LastBadIdx: The index of the last element that was out of bounds [MinK, MaxK].
    %                    Initialized to -1, meaning no bad element seen yet.
    %        LastMinKIdx: The index of the last occurrence of MinK.
    %                     Initialized to -1, meaning MinK not seen yet.
    %        LastMaxKIdx: The index of the last occurrence of MaxK.
    %                     Initialized to -1, meaning MaxK not seen yet.
    count_subarrays_recursive(Nums, 0, MinK, MaxK, {0, -1, -1, -1}).

count_subarrays_recursive([], _J, _MinK, _MaxK, {TotalCount, _, _, _}) ->
    % Base case: When the list is empty, return the accumulated total count.
    TotalCount;
count_subarrays_recursive([X | Rest], J, MinK, MaxK, {TotalCount, LastBadIdx, LastMinKIdx, LastMaxKIdx}) ->
    % Determine the new LastBadIdx. If X is out of bounds, update it to J.
    NewLastBadIdx = if X < MinK or X > MaxK -> J; true -> LastBadIdx end,

    % Determine the new LastMinKIdx. If X is MinK, update it to J.
    NewLastMinKIdx = if X == MinK -> J; true -> LastMinKIdx end,

    % Determine the new LastMaxKIdx. If X is MaxK, update it to J.
    NewLastMaxKIdx = if X == MaxK -> J; true -> LastMaxKIdx end,

    % Calculate the number of valid subarrays ending at the current index J.
    % A subarray nums[k..J] is valid if:
    % 1. All elements nums[i] for k <= i <= J are within [MinK, MaxK].
    %    This implies k must be greater than NewLastBadIdx. So, k >= NewLastBadIdx + 1.
    % 2. MinK is present in nums[k..J]. This implies k must be less than or equal to NewLastMinKIdx.
    % 3. MaxK is present in nums[k..J]. This implies k must be less than or equal to NewLastMaxKIdx.
    %
    % Combining these, k must satisfy:
    % NewLastBadIdx + 1 <= k <= erlang:min(NewLastMinKIdx, NewLastMaxKIdx)
    %
    % The number of such k values is:
    % erlang:min(NewLastMinKIdx, NewLastMaxKIdx) - (NewLastBadIdx + 1) + 1
    % which simplifies to:
    % erlang:min(NewLastMinKIdx, NewLastMaxKIdx) - NewLastBadIdx
    %
    % We use erlang:max(0, ...) to ensure we only add non-negative counts.
    % If the range for k is invalid (e.g., NewLastBadIdx + 1 > erlang:min(NewLastMinKIdx, NewLastMaxKIdx)),
    % then the expression will be negative or zero, and max(0, ...) will correctly yield 0.
    Contribution = erlang:max(0, erlang:min(NewLastMinKIdx, NewLastMaxKIdx) - NewLastBadIdx),

    % Update the total count.
    NewTotalCount = TotalCount + Contribution,

    % Recursively call with the rest of the list, incremented index, and updated state.
    count_subarrays_recursive(Rest, J + 1, MinK, MaxK, {NewTotalCount, NewLastBadIdx, NewLastMinKIdx, NewLastMaxKIdx}).