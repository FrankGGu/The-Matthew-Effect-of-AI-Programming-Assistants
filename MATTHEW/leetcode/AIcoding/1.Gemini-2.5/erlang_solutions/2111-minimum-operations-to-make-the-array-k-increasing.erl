-module(solution).
-export([k_increasing/2]).

k_increasing(Arr, K) ->
    N = length(Arr),

    %% Step 1: Distribute elements into K separate subsequences.
    %% We use Erlang's 'array' module to store the K subsequences efficiently.
    %% Each element of the array will be a list representing a subsequence.
    %% Initial array of K empty lists.
    SubsequencesArray = array:new([{size, K}, {default, []}]),

    %% Distribute elements from the input array 'Arr' into 'SubsequencesArray'.
    DistributedSubsequences = distribute_elements(Arr, K, 0, SubsequencesArray),

    %% Step 2: For each of the K subsequences, calculate the minimum operations
    %% needed to make it non-decreasing, and sum these operations.
    TotalOps = calculate_total_ops(0, K, DistributedSubsequences, 0),
    TotalOps.

distribute_elements([], _K, _Index, AccArray) ->
    AccArray;
distribute_elements([H|T], K, Index, AccArray) ->
    SubIdx = Index rem K, % Determine which subsequence this element belongs to
    CurrentSub = array:get(SubIdx, AccArray),
    UpdatedSub = [H | CurrentSub], % Prepend element to the current subsequence list
    NewAccArray = array:set(SubIdx, UpdatedSub, AccArray), % Update the array
    distribute_elements(T, K, Index + 1, NewAccArray).

calculate_total_ops(J, K, SubsequencesArray, AccOps) when J < K ->
    Subsequence = lists:reverse(array:get(J, SubsequencesArray)), % Get and reverse subsequence to restore original order
    SubLength = length(Subsequence),
    LNDSLength = lnds(Subsequence), % Calculate the length of the Longest Non-Decreasing Subsequence
    OpsForSub = SubLength - LNDSLength, % Operations = total length - LNDS length
    calculate_total_ops(J + 1, K, SubsequencesArray, AccOps + OpsForSub);
calculate_total_ops(_J, _K, _SubsequencesArray, AccOps) ->
    AccOps.

lnds(List) ->
    lnds_fold(List, array:new()).

lnds_fold([], TailsArray) ->
    array:size(TailsArray); % The size of the 'TailsArray' is the length of the LNDS
lnds_fold([H|T], TailsArray) ->
    Size = array:size(TailsArray),
    NewTailsArray =
        if Size == 0 ->
            array:set(0, H, TailsArray); % If tails array is empty, start with H
        true ->
            Last = array:get(Size - 1, TailsArray),
            if H >= Last ->
                array:set(Size, H, TailsArray); % If H is greater than or equal to the last element, append it (extends LNDS)
            true ->
                %% Otherwise, find the smallest element in TailsArray that is >= H
                %% and replace it with H. This is done using binary search (lower_bound).
                Idx = binary_search_lower_bound(H, TailsArray, 0, Size - 1),
                array:set(Idx, H, TailsArray) % Replace the element at the found index
            end
        end,
    lnds_fold(T, NewTailsArray).

binary_search_lower_bound(X, Arr, Low, High) ->
    %% 'High + 1' is the default result if no element >= X is found (i.e., all elements are smaller)
    binary_search_lower_bound_rec(X, Arr, Low, High, High + 1).

binary_search_lower_bound_rec(_X, _Arr, Low, High, Ans) when Low > High ->
    Ans; % Base case: search range is invalid, return the current best answer
binary_search_lower_bound_rec(X, Arr, Low, High, Ans) ->
    Mid = Low + (High - Low) div 2, % Calculate mid-point to prevent overflow
    Element = array:get(Mid, Arr),
    if Element >= X ->
        %% Element at 'Mid' is a potential candidate. Store 'Mid' as a possible answer
        %% and try to find an even earlier element in the left half.
        binary_search_lower_bound_rec(X, Arr, Low, Mid - 1, Mid);
    true ->
        %% Element at 'Mid' is too small, so look in the right half.
        binary_search_lower_bound_rec(X, Arr, Mid + 1, High, Ans)
    end.