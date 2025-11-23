-module(solution).
-export([maxOperations/1]).

maxOperations(Nums) ->
    SortedNumsList = lists:sort(Nums),
    N = length(SortedNumsList),
    SortedNums = list_to_tuple(SortedNumsList), % Convert to tuple for O(1) access

    % F_inner(Left, Right, TargetScore, Memo) is the memoized DP function.
    % Left and Right are 1-indexed indices for the tuple SortedNums.
    % Memo is a map storing results for {Left, Right} states.
    % Returns: {MaxOperations, UpdatedMemo} for the current call.
    F_inner =
        fun F_inner(Left, Right, TargetScore, Memo) ->
            if Left >= Right ->
                {0, Memo};
            true ->
                case maps:find({Left, Right}, Memo) of
                    {ok, Result} ->
                        {Result, Memo};
                    _ ->
                        ValLeft = element(Left, SortedNums),
                        ValRight = element(Right, SortedNums),

                        Ops1 = 0,
                        % Option 1: Pick SortedNums[Left] and SortedNums[Left+1]
                        if Left + 1 =< Right ->
                            ValLeftPlus1 = element(Left + 1, SortedNums),
                            IfLeftLeftSum = ValLeft + ValLeftPlus1,
                            if IfLeftLeftSum == TargetScore ->
                                {Res1, _} = F_inner(Left + 2, Right, TargetScore, Memo), % Recurse, pass current Memo
                                Ops1 = 1 + Res1;
                            true ->
                                ok
                            end;
                        true ->
                            ok
                        end,

                        Ops2 = 0,
                        % Option 2: Pick SortedNums[Left] and SortedNums[Right]
                        IfLeftRightSum = ValLeft + ValRight,
                        if IfLeftRightSum == TargetScore ->
                            {Res2, _} = F_inner(Left + 1, Right - 1, TargetScore, Memo), % Recurse, pass current Memo
                            Ops2 = 1 + Res2;
                        true ->
                            ok
                        end,

                        Ops3 = 0,
                        % Option 3: Pick SortedNums[Right-1] and SortedNums[Right]
                        if Right - 1 >= Left ->
                            ValRightMinus1 = element(Right - 1, SortedNums),
                            IfRightRightSum = ValRightMinus1 + ValRight,
                            if IfRightRightSum == TargetScore ->
                                {Res3, _} = F_inner(Left, Right - 2, TargetScore, Memo), % Recurse, pass current Memo
                                Ops3 = 1 + Res3;
                            true ->
                                ok
                            end;
                        true ->
                            ok
                        end,

                        CurrentMax = lists:max([Ops1, Ops2, Ops3]),
                        UpdatedMemo = maps:put({Left, Right}, CurrentMax, Memo), % Store result in Memo
                        {CurrentMax, UpdatedMemo}
                end
            end
        end,

    % run_dp(InitialLeft, InitialRight, TargetScore)
    % Runs the DP for a specific target score, starting with a fresh memo.
    % Returns the maximum operations for that target score.
    run_dp = fun(InitialLeft, InitialRight, TargetScore) ->
        {Result, _} = F_inner(InitialLeft, InitialRight, TargetScore, maps:new()),
        Result
    end,

    % Calculate maximum operations for three possible initial target scores.
    % Each calculation starts with 1 operation (the initial pair) + recursive calls.

    % Case 1: First two elements (SortedNums[1] and SortedNums[2]) form the initial pair.
    Score1 = element(1, SortedNums) + element(2, SortedNums),
    MaxOps1 = 1 + run_dp(3, N, Score1),

    % Case 2: First and last elements (SortedNums[1] and SortedNums[N]) form the initial pair.
    Score2 = element(1, SortedNums) + element(N, SortedNums),
    MaxOps2 = 1 + run_dp(2, N - 1, Score2),

    % Case 3: Last two elements (SortedNums[N-1] and SortedNums[N]) form the initial pair.
    Score3 = element(N - 1, SortedNums) + element(N, SortedNums),
    MaxOps3 = 1 + run_dp(1, N - 2, Score3),

    % The overall maximum is the best among these three possibilities.
    lists:max([MaxOps1, MaxOps2, MaxOps3]).