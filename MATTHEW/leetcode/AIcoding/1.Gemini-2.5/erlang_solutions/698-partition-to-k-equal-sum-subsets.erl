-module(solution).
-export([canPartitionKSubsets/2]).

canPartitionKSubsets(Nums, K) ->
    TotalSum = lists:sum(Nums),
    Length = length(Nums),

    if
        TotalSum rem K /= 0 -> false;
        Length < K -> false;
        true ->
            TargetSum = TotalSum div K,
            SortedNums = lists:sort(fun(A, B) -> A >= B end, Nums),

            case SortedNums of
                [] -> K == 0;
                [H|_] when H > TargetSum -> false;
                _ ->
                    NumsArray = array:from_list(SortedNums),

                    InitialMemo = dict:new(),
                    {Result, _FinalMemo} = backtrack(NumsArray, TargetSum, 0, 0, K, InitialMemo),
                    Result
            end
    end.

backtrack(NumsArray, TargetSum, UsedMask, CurrentSubsetSum, NumSubsetsRemaining, Memo) ->
    if NumSubsetsRemaining == 0 ->
        {true, Memo};
    true ->
        if CurrentSubsetSum == TargetSum ->
            backtrack(NumsArray, TargetSum, UsedMask, 0, NumSubsetsRemaining - 1, Memo);
        true ->
            if CurrentSubsetSum == 0 andalso dict:is_key(UsedMask, Memo) ->
                {dict:fetch(UsedMask, Memo), Memo};
            true ->
                Length = array:size(NumsArray),
                {Result, UpdatedMemo} = try_next_num(0, Length, NumsArray, TargetSum, UsedMask, CurrentSubsetSum, NumSubsetsRemaining, Memo),

                if CurrentSubsetSum == 0 ->
                    {Result, dict:store(UsedMask, Result, UpdatedMemo)};
                true ->
                    {Result, UpdatedMemo}
                end
            end
        end
    end.

try_next_num(Idx, Length, NumsArray, TargetSum, UsedMask, CurrentSubsetSum, NumSubsetsRemaining, Memo) ->
    if Idx == Length ->
        {false, Memo};
    true ->
        Num = array:get(Idx, NumsArray),
        IsUsed = (UsedMask band (1 bsl Idx)) /= 0,

        if not IsUsed andalso (CurrentSubsetSum + Num <= TargetSum) ->
            NewUsedMask = UsedMask bor (1 bsl Idx),
            NewCurrentSubsetSum = CurrentSubsetSum + Num,

            {Found, UpdatedMemo1} = backtrack(NumsArray, TargetSum, NewUsedMask, NewCurrentSubsetSum, NumSubsetsRemaining, Memo),
            if Found ->
                {true, UpdatedMemo1};
            true ->
                try_next_num(Idx + 1, Length, NumsArray, TargetSum, UsedMask, CurrentSubsetSum, NumSubsetsRemaining, UpdatedMemo1)
            end;
        true ->
            try_next_num(Idx + 1, Length, NumsArray, TargetSum, UsedMask, CurrentSubsetSum, NumSubsetsRemaining, Memo)
        end
    end.