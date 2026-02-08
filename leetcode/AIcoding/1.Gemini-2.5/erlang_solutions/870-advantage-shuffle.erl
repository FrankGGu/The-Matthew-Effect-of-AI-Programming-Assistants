-module(solution).
-export([advantage_shuffle/2]).

advantage_shuffle(Nums1, Nums2) ->
    N = length(Nums1),

    % 1. Sort Nums1 in ascending order.
    SortedNums1 = lists:sort(Nums1),
    SortedNums1_Arr = array:from_list(SortedNums1),

    % 2. Pair elements of Nums2 with their original indices and sort by value.
    IndexedNums2 = lists:zip(Nums2, lists:seq(0, N-1)),
    SortedIndexedNums2 = lists:sort(fun({V1, _}, {V2, _}) -> V1 =< V2 end, IndexedNums2),
    SortedIndexedNums2_Arr = array:from_list(SortedIndexedNums2),

    % 3. Initialize the result array with N elements.
    AnsArray = array:new(N),

    % 4. Call the recursive helper function with two pointers for each sorted array.
    %    LeftA, RightA: pointers for SortedNums1_Arr (smallest and largest available elements)
    %    LeftB, RightB: pointers for SortedIndexedNums2_Arr (smallest and largest available elements)
    FinalAnsArray = advantage_shuffle_recursive(0, N-1, 0, N-1, SortedNums1_Arr, SortedIndexedNums2_Arr, AnsArray),

    % 5. Convert the final result array to a list.
    array:to_list(FinalAnsArray).

advantage_shuffle_recursive(LeftA, RightA, LeftB, RightB, SortedNums1_Arr, SortedIndexedNums2_Arr, AnsArray) ->
    % Base case: All elements of Nums2 have been processed.
    % This occurs when the LeftB pointer crosses the RightB pointer.
    if
        LeftB > RightB -> AnsArray;
        true ->
            % Get the smallest available element from SortedNums1_Arr.
            A_Left_Val = array:get(LeftA, SortedNums1_Arr),

            % Get the smallest available element from SortedIndexedNums2_Arr (with its original index).
            {B_Left_Val, B_Left_Idx} = array:get(LeftB, SortedIndexedNums2_Arr),

            if
                % If A_Left_Val can beat B_Left_Val, it's an optimal match.
                % We use the smallest possible Nums1 element that can beat the smallest Nums2 element.
                A_Left_Val > B_Left_Val ->
                    NewAnsArray = array:set(B_Left_Idx, A_Left_Val, AnsArray),
                    % Move both LeftA and LeftB pointers forward.
                    advantage_shuffle_recursive(LeftA + 1, RightA, LeftB + 1, RightB, SortedNums1_Arr, SortedIndexedNums2_Arr, NewAnsArray);
                % If A_Left_Val cannot beat B_Left_Val, this Nums1 element will result in a loss.
                % To maximize advantage, "waste" this small A_Left_Val on the largest available Nums2 element
                % (which we are likely to lose against anyway) to save potentially larger Nums1 elements
                % for other Nums2 elements they might beat.
                true ->
                    % Get the largest available element from SortedIndexedNums2_Arr (with its original index).
                    {_B_Right_Val, B_Right_Idx} = array:get(RightB, SortedIndexedNums2_Arr),

                    NewAnsArray = array:set(B_Right_Idx, A_Left_Val, AnsArray),
                    % Move LeftA pointer forward and RightB pointer backward.
                    advantage_shuffle_recursive(LeftA + 1, RightA, LeftB, RightB - 1, SortedNums1_Arr, SortedIndexedNums2_Arr, NewAnsArray)
            end
    end.