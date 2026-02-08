-spec zero_array_transformation(Nums :: [integer()]) -> integer().
zero_array_transformation(Nums) ->
    N = length(Nums),
    zero_array_transformation_impl(N - 1, Nums, 0, 0).

zero_array_transformation_impl(-1, _Nums, Ans, _CurrentOpsVal) ->
    Ans;
zero_array_transformation_impl(I, Nums, Ans, CurrentOpsVal) ->
    NumI = lists:nth(I + 1, Nums), % Nums is 1-indexed for lists:nth, I is 0-indexed
    NeededToZero = NumI - CurrentOpsVal,
    {NewAns, NewCurrentOpsVal} = 
        if NeededToZero > 0 -> 
            % If nums[I] still needs to be reduced, perform one operation starting at I.
            % The 'k' value for this operation is 'NeededToZero'.
            % This operation counts as 1 towards the total answer.
            % It adds 'NeededToZero' to the 'CurrentOpsVal' for nums[I].
            {Ans + 1, CurrentOpsVal + NeededToZero};
           true -> 
            % No operation needed at I, or nums[I] is already over-reduced (should not happen with this greedy).
            {Ans, CurrentOpsVal}
        end,
    % For the next index (I-1), the effect of operations that started at I
    % (and potentially before I) will be reduced by 1.
    % An operation that reduces nums[I] by 'k' reduces nums[I-1] by 'k-1'.
    UpdatedCurrentOpsVal = max(0, NewCurrentOpsVal - 1),
    zero_array_transformation_impl(I - 1, Nums, NewAns, UpdatedCurrentOpsVal).