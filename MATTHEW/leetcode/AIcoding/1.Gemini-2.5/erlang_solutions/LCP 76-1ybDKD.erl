-module(solution).
-export([magical_chessboard/2]).

magical_chessboard(N, K) ->
    % Helper function to calculate the sum of an arithmetic progression:
    % sum_{i=A}^{B} (C*i + D)
    SumArithProg = fun(A, B, C, D) ->
        if A > B ->
            0;
        true ->
            Count = B - A + 1,
            SumI = Count * (A + B) div 2,
            C * SumI + D * Count
        end
    end,

    % Part 1: Sum for s = r + c where 0 <= s < N
    % For these s, the number of cells is s + 1.
    % We consider s values that are multiples of K: s = m * K.
    % So, we sum (m * K + 1) for m where 0 <= m * K < N.
    % This means 0 <= m < N / K.
    % m ranges from 0 to floor((N - 1) / K).
    M1 = (N - 1) div K,
    Sum1 = SumArithProg(0, M1, K, 1),

    % Part 2: Sum for s = r + c where N <= s <= 2*N - 2
    % For these s, the number of cells is 2*N - 1 - s.
    % We consider s values that are multiples of K: s = m * K.
    % So, we sum (2*N - 1 - m * K) for m where N <= m * K <= 2*N - 2.
    % This means N/K <= m <= (2*N - 2)/K.
    % m ranges from ceil(N / K) to floor((2*N - 2) / K).
    M2_start = (N + K - 1) div K, % equivalent to ceil(N/K)
    M2_end = (2*N - 2) div K,     % equivalent to floor((2*N-2)/K)
    Sum2 = SumArithProg(M2_start, M2_end, -K, 2*N - 1),

    Sum1 + Sum2.