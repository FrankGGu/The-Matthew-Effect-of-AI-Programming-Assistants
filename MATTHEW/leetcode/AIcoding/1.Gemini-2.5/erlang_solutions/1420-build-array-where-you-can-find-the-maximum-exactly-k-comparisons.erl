-module(solution).
-export([build_array/3]).

build_array(N, M, K) ->
    MOD = 1000000007,

    % dp[i][l][j] = number of ways to build an array of length i,
    % with exactly l comparisons, and the maximum element is j.
    % gb_array is 1-indexed.
    % Dp: gb_array(N+1) of gb_array(K+1) of gb_array(M+1) of integer
    % PrefixSum: gb_array(N+1) of gb_array(K+1) of gb_array(M+1) of integer

    % Initialize Dp and PrefixSum as 3D gb_arrays filled with 0s.
    % gb_array:new(Size, DefaultValue)
    EmptyMArray = gb_array:new(M + 1, 0),
    EmptyKArray = gb_array:new(K + 1, EmptyMArray),
    Dp = gb_array:new(N + 1, EmptyKArray),
    PrefixSum = gb_array:new(N + 1, EmptyKArray),

    % Base cases for I = 1
    % Dp[1][1][J] = 1 for J from 1 to M
    % PrefixSum[1][1][J] = sum(Dp[1][1][x] for x from 1 to J)

    % Get the gb_array for I=1
    DpI1 = gb_array:get(1, Dp),
    PrefixSumI1 = gb_array:get(1, PrefixSum),

    % Get the gb_array for L=1 within I=1
    DpI1L1 = gb_array:get(1, DpI1),
    PrefixSumI1L1 = gb_array:get(1, PrefixSumI1),

    CurrentSum = 0,
    NewDpI1L1 = DpI1L1, % Start with the default (all zeros) array
    NewPrefixSumI1L1 = PrefixSumI1L1, % Start with the default (all zeros) array

    for J <- 1..M do
        NewDpI1L1 = gb_array:set(J, 1, NewDpI1L1),
        CurrentSum = (CurrentSum + 1) rem MOD,
        NewPrefixSumI1L1 = gb_array:set(J, CurrentSum, NewPrefixSumI1L1)
    end,

    % Update the nested gb_arrays
    DpI1 = gb_array:set(1, NewDpI1L1, DpI1),
    Dp = gb_array:set(1, DpI1, Dp),

    PrefixSumI1 = gb_array:set(1, NewPrefixSumI1L1, PrefixSumI1),
    PrefixSum = gb_array:set(1, PrefixSumI1, PrefixSum),

    % Main loops for I from 2 to N
    for I <- 2..N do
        % Get current and previous states of the gb_arrays for I and I-1
        DpI = gb_array:get(I, Dp),
        PrefixSumI = gb_array:get(I, PrefixSum),
        DpPrevI = gb_array:get(I-1, Dp),
        PrefixSumPrevI = gb_array:get(I-1, PrefixSum),

        for L <- 1..K do
            % If L > I, it's impossible to have L comparisons for an array of length I.
            % All values will remain 0, so we can skip this L.
            if L =< I ->
                % Get current and previous states of the gb_arrays for L and L-1
                DpIL = gb_array:get(L, DpI),
                PrefixSumIL = gb_array:get(L, PrefixSumI),
                DpPrevIL = gb_array:get(L, DpPrevI),

                CurrentSum = 0, % This will accumulate prefix sum for PrefixSumIL
                for J <- 1..M do
                    Val = 0,

                    % Case 1: J is the new maximum
                    % This requires L-1 comparisons for the first I-1 elements,
                    % and their maximum was less than J.
                    % Sum dp[I-1][L-1][prev_J] for prev_J from 1 to J-1.
                    % This sum is PrefixSum[I-1][L-1][J-1].
                    if L > 1 ->
                        PrefixSumPrevILMinus1 = gb_array:get(L-1, PrefixSumPrevI),
                        if J > 1 ->
                            Val = (Val + gb_array:get(J-1, PrefixSumPrevILMinus1)) rem MOD
                        else
                            ok % J=1, no prev_J < 1
                        end
                    else
                        ok % L=1, cannot have L-1 comparisons
                    end,

                    % Case 2: J is NOT the new maximum
                    % The maximum was already J among the first I-1 elements,
                    % and L comparisons were made.
                    % The I-th element can be any value from 1 to J.
                    Val = (Val + gb_array:get(J, DpPrevIL) * J) rem MOD,

                    NewDpIL = gb_array:set(J, Val, DpIL), % Update DpIL for current J
                    DpIL = NewDpIL, % Assign updated array back to DpIL for next iteration

                    CurrentSum = (CurrentSum + Val) rem MOD,
                    NewPrefixSumIL = gb_array:set(J, CurrentSum, PrefixSumIL), % Update PrefixSumIL for current J
                    PrefixSumIL = NewPrefixSumIL % Assign updated array back to PrefixSumIL for next iteration
                end,
                % Update the nested gb_arrays after iterating through all J for current I, L
                DpI = gb_array:set(L, DpIL, DpI),
                PrefixSumI = gb_array:set(L, PrefixSumIL, PrefixSumI)
            else
                ok % L > I, skip
            end
        end,
        % Update the nested gb_arrays after iterating through all L for current I
        Dp = gb_array:set(I, DpI, Dp),
        PrefixSum = gb_array:set(I, PrefixSumI, PrefixSum)
    end,

    % Final result: sum(Dp[N][K][J] for J from 1 to M)
    Ans = 0,
    DpN = gb_array:get(N, Dp),
    DpNK = gb_array:get(K, DpN), % This is the gb_array for length N, K comparisons
    for J <- 1..M do
        Ans = (Ans + gb_array:get(J, DpNK)) rem MOD
    end,
    Ans.