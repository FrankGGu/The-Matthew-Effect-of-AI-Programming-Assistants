-module(solution).
-export([longestNonDecreasingSubarray/2]).

longestNonDecreasingSubarray(Nums1, Nums2) ->
    N = length(Nums1),
    case N of
        0 -> 0;
        1 -> 1;
        _ ->
            % Initial state for index 0
            % Dp0: length of longest non-decreasing subarray ending at index 0, using Nums1[0]
            % Dp1: length of longest non-decreasing subarray ending at index 0, using Nums2[0]
            % CurrentMaxLen: overall maximum length found so far
            % PrevN1Val: Nums1[0]
            % PrevN2Val: Nums2[0]
            {PrevN1Val, PrevN2Val} = {hd(Nums1), hd(Nums2)},
            InitialAcc = {1, 1, 1, PrevN1Val, PrevN2Val},

            % Create a list of tuples for iteration: [{Nums1[1], Nums2[1]}, ..., {Nums1[N-1], Nums2[N-1]}]
            PairedTails = lists:zip(tl(Nums1), tl(Nums2)),

            % Fold over the paired elements from index 1 to N-1
            % Acc: {Dp0_prev, Dp1_prev, CurrentMaxLen_prev, N1_prev_val, N2_prev_val}
            % Elem: {N1_curr_val, N2_curr_val}
            {_FinalDp0, _FinalDp1, MaxLen, _FinalPrevN1, _FinalPrevN2} = 
                lists:foldl(
                    fun({CurrN1, CurrN2}, {Dp0_prev, Dp1_prev, CurrentMaxLen_prev, N1_prev_val, N2_prev_val}) ->
                        % Initialize NewDp0 and NewDp1 to 1 (current element itself forms a subarray of length 1)
                        NewDp0 = 1,
                        NewDp1 = 1,

                        % Calculate potential values for NewDp0 (ending with CurrN1)
                        % Can extend from Dp0_prev if CurrN1 >= N1_prev_val
                        PotentialDp0_from_N1_prev = if CurrN1 >= N1_prev_val -> Dp0_prev + 1; true -> 0 end,
                        % Can extend from Dp1_prev if CurrN1 >= N2_prev_val
                        PotentialDp0_from_N2_prev = if CurrN1 >= N2_prev_val -> Dp1_prev + 1; true -> 0 end,

                        % Final NewDp0 is the max of starting new (1) or extending previous valid paths
                        FinalNewDp0 = max(NewDp0, max(PotentialDp0_from_N1_prev, PotentialDp0_from_N2_prev)),

                        % Calculate potential values for NewDp1 (ending with CurrN2)
                        % Can extend from Dp0_prev if CurrN2 >= N1_prev_val
                        PotentialDp1_from_N1_prev = if CurrN2 >= N1_prev_val -> Dp0_prev + 1; true -> 0 end,
                        % Can extend from Dp1_prev if CurrN2 >= N2_prev_val
                        PotentialDp1_from_N2_prev = if CurrN2 >= N2_prev_val -> Dp1_prev + 1; true -> 0 end,

                        % Final NewDp1 is the max of starting new (1) or extending previous valid paths
                        FinalNewDp1 = max(NewDp1, max(PotentialDp1_from_N1_prev, PotentialDp1_from_N2_prev)),

                        % Update overall maximum length
                        NewMaxLen = max(CurrentMaxLen_prev, max(FinalNewDp0, FinalNewDp1)),

                        % Return updated accumulator for the next iteration
                        {FinalNewDp0, FinalNewDp1, NewMaxLen, CurrN1, CurrN2}
                    end,
                    InitialAcc,
                    PairedTails
                ),
            MaxLen
    end.