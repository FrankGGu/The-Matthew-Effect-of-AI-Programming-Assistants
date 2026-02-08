-module(solution).
-export([min_operations/3]).

min_operations(Nums1, Nums2, K) ->
    if K == 0 ->
        check_k_zero(Nums1, Nums2);
    true ->
        process_k_positive(Nums1, Nums2, K)
    end.

check_k_zero(Nums1, Nums2) ->
    lists:foldl(fun({N1, N2}, Acc) ->
                    if Acc == -1 -> -1;
                       N1 == N2 -> Acc;
                       true -> -1
                    end
                end, 0, lists:zip(Nums1, Nums2)).

process_k_positive(Nums1, Nums2, K) ->
    % Acc: {Status, TotalDiffSum, IncOpsCount}
    % Status: 0 for possible, -1 for impossible
    {Status, TotalDiffSum, IncOpsCount} = lists:foldl(
        fun({N1, N2}, {CurrentStatus, CurrentTotalDiffSum, CurrentIncOpsCount}) ->
            if CurrentStatus == -1 ->
                {-1, 0, 0};
            true ->
                Diff = N2 - N1,
                if Diff rem K == 0 ->
                    NewTotalDiffSum = CurrentTotalDiffSum + Diff,
                    NewIncOpsCount = if Diff > 0 -> CurrentIncOpsCount + (Diff div K);
                                        true -> CurrentIncOpsCount
                                     end,
                    {0, NewTotalDiffSum, NewIncOpsCount};
                true ->
                    {-1, 0, 0}
                end
            end
        end,
        {0, 0, 0},
        lists:zip(Nums1, Nums2)
    ),
    if Status == -1 ->
        -1;
    TotalDiffSum == 0 ->
        IncOpsCount;
    true ->
        -1
    end.