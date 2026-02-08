-module(solution).
-export([largestDivisibleSubset/1]).

largestDivisibleSubset(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),

    % dp[i] will store the length of the largest divisible subset ending with SortedNums[i]
    % parent[i] will store the index of the previous element in that subset
    % Initialize dp with 1s and parent with -1s
    % Use array module for efficient updates and lookups
    Dp = array:new([{size, N}, {default, 1}]),
    Parent = array:new([{size, N}, {default, -1}]),

    MaxLen = 0,
    MaxIdx = -1,

    % Convert sorted list to array for O(1) indexed access
    NumsArr = array:from_list(SortedNums),

    % Iterate through the numbers to fill DP tables
    {_FinalDp, FinalParent, _FinalMaxLen, FinalMaxIdx} =
        lists:foldl(
            fun(I, {CurrentDp, CurrentParent, CurrentMaxLen, CurrentMaxIdx}) ->
                N_i = array:get(I, NumsArr),
                CurrentDpI = array:get(I, CurrentDp), % Initial dp[i] value (at least 1)

                % Inner loop to find the best previous element j for current i
                {UpdatedDpI, UpdatedParentI} =
                    lists:foldl(
                        fun(J, {AccDpI, AccParentI}) ->
                            N_j = array:get(J, NumsArr),
                            if N_i rem N_j == 0 ->
                                CurrentDpJ = array:get(J, CurrentDp),
                                if CurrentDpJ + 1 > AccDpI ->
                                    {CurrentDpJ + 1, J};
                                    true ->
                                    {AccDpI, AccParentI}
                                end;
                                true ->
                                {AccDpI, AccParentI}
                            end
                        end,
                        {CurrentDpI, -1}, % Initial state for inner foldl: current element itself forms a subset of length 1, no parent
                        lists:seq(0, I - 1) % Iterate j from 0 to i-1
                    ),

                % Update the DP and Parent arrays for index I
                NewDp = array:set(I, UpdatedDpI, CurrentDp),
                NewParent = array:set(I, UpdatedParentI, CurrentParent),

                % Update overall max length and index if a longer subset is found
                if UpdatedDpI > CurrentMaxLen ->
                    {NewDp, NewParent, UpdatedDpI, I};
                    true ->
                    {NewDp, NewParent, CurrentMaxLen, CurrentMaxIdx}
                end
            end,
            {Dp, Parent, MaxLen, MaxIdx},
            lists:seq(0, N - 1) % Iterate i from 0 to N-1
        ),

    % Reconstruct the largest divisible subset using the parent array
    reconstruct_subset(FinalParent, NumsArr, FinalMaxIdx, []).

reconstruct_subset(_Parent, _NumsArr, -1, Acc) ->
    lists:reverse(Acc); % Base case: reached the beginning of the subset
reconstruct_subset(Parent, NumsArr, CurrentIdx, Acc) ->
    Num = array:get(CurrentIdx, NumsArr),
    NextIdx = array:get(CurrentIdx, Parent),
    reconstruct_subset(Parent, NumsArr, NextIdx, [Num | Acc]).