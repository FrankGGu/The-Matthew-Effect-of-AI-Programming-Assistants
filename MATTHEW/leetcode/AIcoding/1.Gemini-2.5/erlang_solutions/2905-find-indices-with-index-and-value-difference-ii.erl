-module(solution).
-export([find_indices/3]).

find_indices(Nums, IndexDifference, ValueDifference) ->
    Arr = array:from_list(Nums),
    N = array:size(Arr),

    % Handle edge cases where a solution is impossible:
    % 1. If there are fewer than 2 elements, no distinct indices exist.
    % 2. If the required index difference is greater than the maximum possible difference (N-1),
    %    no pair of indices can satisfy the condition.
    if N < 2 ->
        [-1, -1];
    IndexDifference > N - 1 ->
        [-1, -1];
    true ->
        % Initialize the minimum and maximum values seen so far in the prefix,
        % along with their corresponding indices.
        % The initial prefix considered is just the first element (index 0).
        InitialMinVal = array:get(0, Arr),
        InitialMaxVal = array:get(0, Arr),
        InitialMinIdx = 0,
        InitialMaxIdx = 0,

        % Start iterating with 'j' from 'IndexDifference' up to 'N-1'.
        % For each 'j', we consider 'i' in the range [0, j - IndexDifference].
        % The 'k' variable in the loop represents 'j - IndexDifference',
        % which is the latest index to potentially update our running min/max.
        find_indices_loop(IndexDifference, ValueDifference, Arr, N,
                          InitialMinVal, InitialMinIdx, InitialMaxVal, InitialMaxIdx, IndexDifference)
    end.

find_indices_loop(_IndexDifference, _ValueDifference, _Arr, N,
                   _CurrentMinVal, _CurrentMinIdx, _CurrentMaxVal, _CurrentMaxIdx, J) when J >= N ->
    % If the loop completes without finding a suitable pair, return [-1, -1].
    [-1, -1];

find_indices_loop(IndexDifference, ValueDifference, Arr, N,
                   CurrentMinVal, CurrentMinIdx, CurrentMaxVal, CurrentMaxIdx, J) ->
    % 'k' is the index that defines the current prefix window [0, k] for 'i' values.
    % It is always 'J - IndexDifference'.
    K = J - IndexDifference,
    ValK = array:get(K, Arr),

    % Update the running minimum value and its index based on nums[K].
    {UpdatedMinVal, UpdatedMinIdx} =
        if ValK < CurrentMinVal -> {ValK, K};
           true -> {CurrentMinVal, CurrentMinIdx}
        end,

    % Update the running maximum value and its index based on nums[K].
    {UpdatedMaxVal, UpdatedMaxIdx} =
        if ValK > CurrentMaxVal -> {ValK, K};
           true -> {CurrentMaxVal, CurrentMaxIdx}
        end,

    % Get the value at the current index 'J'.
    ValJ = array:get(J, Arr),

    % Check if the current ValJ satisfies the value difference condition with the
    % minimum value found in the valid prefix.
    if abs(ValJ - UpdatedMinVal) >= ValueDifference ->
        [UpdatedMinIdx, J];
    % If not, check against the maximum value found in the valid prefix.
    true ->
        if abs(ValJ - UpdatedMaxVal) >= ValueDifference ->
            [UpdatedMaxIdx, J];
        % If neither condition is met, continue to the next 'J'.
        true ->
            find_indices_loop(IndexDifference, ValueDifference, Arr, N,
                              UpdatedMinVal, UpdatedMinIdx, UpdatedMaxVal, UpdatedMaxIdx, J + 1)
        end
    end.