-module(solution).
-export([rearrange_array/1]).

rearrange_array(Nums) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),

    % Calculate the length of the first half.
    % For odd length, the middle element will be part of the 'Rest' list.
    HalfLen = Len div 2,

    % Split the sorted list into two parts.
    % SmallHalf will contain the smallest elements.
    % Rest will contain the larger elements (and the middle element if Len is odd).
    {SmallHalf, Rest} = lists:split(HalfLen, SortedNums),

    % Reverse the 'Rest' list to get the largest elements at the front.
    ReversedRest = lists:reverse(Rest),

    % Interleave elements from SmallHalf and ReversedRest.
    % We want the pattern: [S1, SN, S2, S(N-1), S3, S(N-2), ...]
    % The `interleave` function builds the result list in reverse order,
    % so we add the larger element (from ReversedRest) then the smaller element (from SmallHalf).
    interleave(SmallHalf, ReversedRest, []).

interleave([], [], Acc) ->
    % Base case: Both lists are empty, reverse the accumulator to get the final result.
    lists:reverse(Acc);
interleave([S | SmallT], [L | LargeT], Acc) ->
    % Take one element from SmallHalf (S) and one from ReversedRest (L).
    % Add L then S to the accumulator (which is built in reverse order).
    % This ensures that when Acc is reversed, S comes before L.
    interleave(SmallT, LargeT, [L, S | Acc]);
interleave([], [L | LargeT], Acc) ->
    % This case handles the scenario where SmallHalf is exhausted,
    % but ReversedRest still contains elements (this happens when the original list length is odd,
    % and L is the middle element, or subsequent elements if the split was uneven).
    interleave([], LargeT, [L | Acc]).