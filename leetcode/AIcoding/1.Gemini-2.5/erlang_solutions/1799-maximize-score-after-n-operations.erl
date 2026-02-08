-module(solution).
-export([max_score/1]).

-spec gcd(A :: integer(), B :: integer()) -> integer().
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

-spec max_score(Nums :: [integer()]) -> integer().
max_score(NumsList) ->
    N = length(NumsList),
    NumsTuple = list_to_tuple(NumsList), % Convert list to tuple for O(1) element access
    InitialMask = (1 bsl N) - 1,         % Bitmask where all bits are set (all numbers available)
    InitialMemo = maps:new(),            % Initialize an empty memoization map
    {Score, _FinalMemo} = solve(InitialMask, 1, N, NumsTuple, InitialMemo),
    Score.

-spec solve(Mask :: integer(), OpNum :: integer(), N :: integer(), NumsTuple :: tuple(), Memo :: map()) -> {integer(), map()}.
solve(Mask, OpNum, N, NumsTuple, Memo) ->
    % Base case: If no numbers are left (Mask is 0) or all N/2 operations are completed.
    if
        Mask == 0; OpNum > N div 2 ->
            {0, Memo}; % No score can be added, return current memo unchanged.
        true ->
            % Check if the result for the current state {Mask, OpNum} is already memoized.
            case maps:find({Mask, OpNum}, Memo) of
                {ok, Score} ->
                    {Score, Memo}; % Return cached score and unchanged memo.
                _ ->
                    % If not in memo, calculate the maximum score for this state.
                    % We initialize the accumulator for foldl with {MaxScore, Memo}.
                    % MaxScore is initially 0, and Memo is the current memo map.
                    Result = lists:foldl(
                        fun(I, Acc) ->
                            CurrentMaxScore = element(1, Acc),
                            CurrentMemo = element(2, Acc),

                            lists:foldl(
                                fun(J, InnerAcc) ->
                                    InnerCurrentMaxScore = element(1, InnerAcc),
                                    InnerCurrentMemo = element(2, InnerAcc),

                                    % Check if both numbers at index I and J are available in the current Mask.
                                    if
                                        (Mask bsand (1 bsl I)) /= 0 andalso (Mask bsand (1 bsl J)) /= 0 ->
                                            % Both numbers are available, form a pair.
                                            NumI = element(I + 1, NumsTuple), % Erlang tuples are 1-indexed.
                                            NumJ = element(J + 1, NumsTuple),
                                            CurrentGCD = gcd(NumI, NumJ),
                                            CurrentPairScore = OpNum * CurrentGCD,

                                            % Create a new mask by removing numbers at I and J.
                                            NewMask = Mask bxor (1 bsl I) bxor (1 bsl J),

                                            % Recursively solve for the remaining state with the updated mask and next operation number.
                                            % The `solve` function returns an updated memo, which we pass along.
                                            {RemainingScore, UpdatedMemoFromRecursion} = solve(NewMask, OpNum + 1, N, NumsTuple, InnerCurrentMemo),

                                            TotalScoreForThisPair = CurrentPairScore + RemainingScore,

                                            % Update the maximum score found so far for this state and the memo.
                                            {max(InnerCurrentMaxScore, TotalScoreForThisPair), UpdatedMemoFromRecursion};
                                        true ->
                                            InnerAcc % If numbers are not available, no change to score or memo.
                                    end
                                end,
                                Acc, % Pass the current accumulator (max score and memo) to the inner foldl.
                                lists:seq(I + 1, N - 1) % Iterate J from I+1 to N-1 to avoid duplicate pairs and self-pairing.
                            )
                        end,
                        {0, Memo}, % Initial accumulator for the outer foldl: {MaxScore, Memo}.
                        lists:seq(0, N - 2) % Iterate I from 0 to N-2.
                    ),

                    CalculatedMaxScore = element(1, Result),
                    FinalMemoForThisBranch = element(2, Result),

                    % Store the calculated maximum score for the current {Mask, OpNum} in the memo.
                    NewMemo = maps:put({Mask, OpNum}, CalculatedMaxScore, FinalMemoForThisBranch),
                    {CalculatedMaxScore, NewMemo}
            end
    end.