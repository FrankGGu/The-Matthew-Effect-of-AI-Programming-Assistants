-module(solution).
-export([max_partitions_after_operations/2]).

is_valid_with_one_op(DistinctCount, FreqMap, K) ->
    if
        DistinctCount =< K ->
            true;
        DistinctCount == K + 1 andalso K > 0 ->
            % If K=0, K+1=1. If DistinctCount=1, cannot make it 0 distinct.
            % For K > 0 and DistinctCount = K+1, we can make it valid if
            % there's at least one character with frequency 1.
            % Changing that character to an existing one reduces distinct count by 1.
            lists:any(fun({_Char, Count}) -> Count == 1 end, maps:to_list(FreqMap));
        true -> % DistinctCount > K+1 OR (DistinctCount == K+1 and K==0)
            false
    end.

max_partitions_after_operations(S, K) ->
    N = length(S),

    % dp[i] = {MaxPartitions0Ops, MaxPartitions1Op} for prefix S[0...i-1]
    % Initialize with -1 to signify unreachable, except dp[0] = {0, 0}
    DP = array:new([{size, N + 1}, {default, {-1, -1}}]),
    DP0 = array:set(0, {0, 0}, DP),

    FinalDP = lists:foldl(
        fun(I, CurrentDP) ->
            % For each i from 1 to N, calculate dp[i]

            % Initialize current_dp_i with {-1, -1}
            CurrentMax0Ops = -1,
            CurrentMax1Op = -1,

            % The accumulator for the inner foldl (J loop) contains:
            % {AccMax0Ops, AccMax1Op, AccFreqMap, AccDistinctCount}
            % AccMax0Ops, AccMax1Op: current maximums for dp[I]
            % AccFreqMap: frequency map for S[J...I-1]
            % AccDistinctCount: number of distinct characters in S[J...I-1]
            {NewCurrentMax0Ops, NewCurrentMax1Op, _, _} = lists:foldl(
                fun(J, {AccMax0Ops, AccMax1Op, AccFreqMap, AccDistinctCount}) ->
                    Char = lists:nth(J + 1, S), % Erlang lists are 1-indexed for nth

                    % Determine if Char is a new distinct character before updating its frequency
                    IsNewDistinct = (maps:get(Char, AccFreqMap, 0) == 0),

                    NewFreqMap = maps:update_with(Char, fun(V) -> V + 1 end, 1, AccFreqMap),

                    NewDistinctCount = 
                        if IsNewDistinct -> AccDistinctCount + 1;
                           true -> AccDistinctCount
                        end,

                    % Get dp[J] values from the DP table (for prefix S[0...J-1])
                    {Prev0Ops, Prev1Op} = array:get(J, CurrentDP),

                    UpdatedMax0Ops = AccMax0Ops,
                    UpdatedMax1Op = AccMax1Op,

                    % Case 1: No operation used in S[0...J-1]
                    if Prev0Ops =/= -1 ->
                        % Check if S[J...I-1] is valid without operation
                        if NewDistinctCount =< K ->
                            UpdatedMax0Ops = max(UpdatedMax0Ops, Prev0Ops + 1)
                        else
                            ok % Not valid, cannot extend Prev0Ops
                        end,
                        % Check if S[J...I-1] can be made valid with one operation
                        % (operation used in current segment S[J...I-1])
                        if is_valid_with_one_op(NewDistinctCount, NewFreqMap, K) ->
                            UpdatedMax1Op = max(UpdatedMax1Op, Prev0Ops + 1)
                        else
                            ok % Not valid even with one operation
                        end;
                        true ->
                            ok % Prev0Ops is -1, cannot extend
                    end,

                    % Case 2: One operation already used in S[0...J-1]
                    if Prev1Op =/= -1 ->
                        % Check if S[J...I-1] is valid without operation
                        % (since operation already used in prefix, current segment must be valid without op)
                        if NewDistinctCount =< K ->
                            UpdatedMax1Op = max(UpdatedMax1Op, Prev1Op + 1)
                        else
                            ok % Not valid, cannot extend Prev1Op
                        end;
                        true ->
                            ok % Prev1Op is -1, cannot extend
                    end,

                    {UpdatedMax0Ops, UpdatedMax1Op, NewFreqMap, NewDistinctCount}
                end,
                {CurrentMax0Ops, CurrentMax1Op, maps:new(), 0}, % Initial state for inner foldl for segment S[J...I-1]
                lists:seq(I - 1, 0, -1) % J from I-1 down to 0
            ),
            array:set(I, {NewCurrentMax0Ops, NewCurrentMax1Op}, CurrentDP)
        end,
        DP0,
        lists:seq(1, N) % I from 1 to N
    ),

    {Result0Ops, Result1Op} = array:get(N, FinalDP),
    % The result should be at least 0. If no partitions are possible, -1 would be returned.
    max(0, max(Result0Ops, Result1Op))
.