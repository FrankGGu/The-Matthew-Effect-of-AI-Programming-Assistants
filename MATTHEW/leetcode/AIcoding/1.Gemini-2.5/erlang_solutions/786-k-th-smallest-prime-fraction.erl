-module(solution).
-export([kthSmallestPrimeFraction/2]).

kthSmallestPrimeFraction(Primes, K) ->
    N = length(Primes),
    PrimesArray = array:from_list(Primes),

    Low = 0.0,
    High = 1.0,

    % Perform binary search for a fixed number of iterations to achieve sufficient precision.
    % 100 iterations are generally enough for double-precision floats.
    {_FinalLow, _FinalHigh, BestNum, BestDen} = binary_search_loop(PrimesArray, N, K, Low, High, 100, 0, 1),

    [BestNum, BestDen].

binary_search_loop(_PrimesArray, _N, _K, Low, High, 0, BestNum, BestDen) ->
    {Low, High, BestNum, BestDen};
binary_search_loop(PrimesArray, N, K, Low, High, Iterations, CurrentBestNum, CurrentBestDen) ->
    Mid = (Low + High) / 2.0,
    {Count, MaxFractionNum, MaxFractionDen} = count_fractions_le(PrimesArray, N, Mid),

    if Count < K ->
        % If fewer than K fractions are <= Mid, then the K-th fraction must be > Mid.
        % Search in the upper half. CurrentBestNum/Den remains unchanged.
        binary_search_loop(PrimesArray, N, K, Mid, High, Iterations - 1, CurrentBestNum, CurrentBestDen);
    true -> % Count >= K
        % If K or more fractions are <= Mid, then the K-th fraction is <= Mid.
        % Search in the lower half. MaxFractionNum/MaxFractionDen is the largest fraction
        % found that is <= Mid, so it's a candidate for the K-th smallest.
        binary_search_loop(PrimesArray, N, K, Low, Mid, Iterations - 1, MaxFractionNum, MaxFractionDen)
    end.

count_fractions_le(PrimesArray, N, X) ->
    % J is the index for the denominator (q), I for the numerator (p).
    % J starts from 0 for array, meaning primes[0]...primes[N-1].
    % Denominator primes[J] starts from J=1 (second element).
    % Numerator primes[I] starts from I=0 (first element).
    count_fractions_le_loop(PrimesArray, N, X, 1, 0, 0, 0, 1).

count_fractions_le_loop(PrimesArray, N, X, J, CurrentI, CurrentCount, BestNum, BestDen) when J < N ->
    Q = array:get(J, PrimesArray),

    % Advance the numerator pointer I for the current denominator Q.
    % Find the largest I' such that PrimesArray[I'] / Q <= X and I' < J.
    % CurrentI is passed to optimize, as the numerator pointer only moves forward.
    NewI = advance_numerator_pointer_loop(PrimesArray, Q, X, CurrentI, J),

    NewCount = CurrentCount + NewI, % NewI is the count of valid numerators (indices 0 to NewI-1)

    % Update BestNum, BestDen if PrimesArray[NewI-1] / Q is larger than the current BestFraction.
    {NextBestNum, NextBestDen} =
        if NewI > 0 ->
            P = array:get(NewI - 1, PrimesArray),
            % Compare P/Q with BestNum/BestDen using cross-multiplication to avoid float precision issues.
            % P/Q > BestNum/BestDen  <=> P * BestDen > BestNum * Q
            if P * BestDen > BestNum * Q ->
                {P, Q};
            true ->
                {BestNum, BestDen}
            end;
        true ->
            {BestNum, BestDen} % No valid numerator found for this Q, keep previous best.
        end,

    count_fractions_le_loop(PrimesArray, N, X, J + 1, NewI, NewCount, NextBestNum, NextBestDen);
count_fractions_le_loop(_PrimesArray, _N, _X, _J, _CurrentI, CurrentCount, BestNum, BestDen) ->
    {CurrentCount, BestNum, BestDen}.

advance_numerator_pointer_loop(PrimesArray, Q, X, I, LimitI) when I < LimitI ->
    P = array:get(I, PrimesArray),
    % Compare P/Q with X. Using float division directly here.
    if (P / Q) =< X ->
        advance_numerator_pointer_loop(PrimesArray, Q, X, I + 1, LimitI);
    true ->
        I % This `I` is the count of valid numerators (0 to I-1)
    end;
advance_numerator_pointer_loop(_PrimesArray, _Q, _X, I, _LimitI) ->
    I.