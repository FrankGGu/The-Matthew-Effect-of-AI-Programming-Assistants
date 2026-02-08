-module(solution).
-export([minimum_operations/1]).

minimum_operations(Nums) ->
    N = length(Nums),

    % dp_table_acc: [{Num_k, Len1_k, Len2_k, Len3_k}, ...]
    % This list will grow with each element processed.
    % Each element in Nums is processed.
    % For each Num, we calculate its {Len1, Len2, Len3} based on previous elements.
    % Len1_k: max length of a valid subsequence ending at Num_k, with Num_k in group 1.
    % Len2_k: max length of a valid subsequence ending at Num_k, with Num_k in group 2.
    % Len3_k: max length of a valid subsequence ending at Num_k, with Num_k in group 3.

    % Initial state for foldl: {CurrentDpTable, CurrentMaxOverallLen}
    % CurrentDpTable is initially empty. CurrentMaxOverallLen is 0.
    {_FinalDpTable, FinalMaxOverallLen} = lists:foldl(
        fun(Num, {CurrentDpTable, CurrentMaxOverallLen}) ->
            % Calculate MaxPrevLen1, MaxPrevLen2, MaxPrevLen3 from previous elements in CurrentDpTable
            % These represent the maximum lengths of valid subsequences ending *before* Num
            % that can be extended by Num into their respective groups.
            {MaxPrevLen1, MaxPrevLen2, MaxPrevLen3} = lists:foldl(
                fun({PrevNum, PrevLen1, PrevLen2, PrevLen3_val}, {Acc1, Acc2, Acc3}) ->
                    if PrevNum =< Num ->
                        {max(Acc1, PrevLen1),
                         max(Acc2, max(PrevLen1, PrevLen2)), % Max length if previous was G1 or G2
                         max(Acc3, max(max(PrevLen1, PrevLen2), PrevLen3_val))} % Max length if previous was G1, G2, or G3
                    else
                        {Acc1, Acc2, Acc3}
                    end
                end, {0, 0, 0}, CurrentDpTable),

            % Calculate current element's lengths
            % If Num is in group 1, it extends a group 1 subsequence.
            CurrentLen1 = MaxPrevLen1 + 1,
            % If Num is in group 2, it can extend a group 1 subsequence (transitioning to G2)
            % or extend a group 2 subsequence.
            CurrentLen2 = max(MaxPrevLen1, MaxPrevLen2) + 1,
            % If Num is in group 3, it can extend a group 1, group 2 (transitioning to G3),
            % or group 3 subsequence.
            CurrentLen3 = max(max(MaxPrevLen1, MaxPrevLen2), MaxPrevLen3) + 1,

            % Update CurrentMaxOverallLen with the maximum length found so far
            NewMaxOverallLen = max(CurrentMaxOverallLen, max(max(CurrentLen1, CurrentLen2), CurrentLen3)),

            % Add current Num's dp values to the table for future calculations
            NewDpTable = CurrentDpTable ++ [{Num, CurrentLen1, CurrentLen2, CurrentLen3}],
            {NewDpTable, NewMaxOverallLen}
        end, {[], 0}, Nums),

    % The minimum number of operations is N minus the maximum length of a valid subsequence.
    N - FinalMaxOverallLen.