-module(solution).
-export([maxUncrossedLines/2]).

maxUncrossedLines(A, B) ->
    N = length(B),
    % InitialPrevRow represents dp[i-1] for the first iteration (i=0),
    % where all values are 0. It has N+1 elements (for j=0 to N).
    InitialPrevRow = lists:duplicate(N + 1, 0),

    % Fold over each element of A (representing rows in the DP table).
    % A_val is A[i-1] for the current row i.
    % PrevRow is the dp row from the previous iteration (dp[i-1]).
    FinalRow = lists:foldl(
        fun(A_val, PrevRow) ->
            % PrevRow: [P0, P1, ..., PN] where Pj = dp[i-1][j]
            % B: [B0, B1, ..., B_{N-1}]
            % We need to compute CurrentRow: [C0, C1, ..., CN] where Cj = dp[i][j]
            % C0 is always 0.
            % For j from 1 to N:
            %   If A_val == B[j-1]: Cj = 1 + P_{j-1}
            %   Else: Cj = max(Pj, C_{j-1})

            % Initial call for the inner loop:
            %   A_val: current element from A
            %   B: the entire list B (elements B[0] to B[N-1])
            %   PrevRow_tail: [P1, P2, ..., PN] (elements of PrevRow from index 1)
            %   Prev_j_minus_1_val: P0 (element of PrevRow at index 0)
            %   Curr_j_minus_1_val: C0 = 0 (element of CurrentRow at index 0, which is always 0)
            %   Acc: [] (accumulator for building CurrentRow, reversed)
            [0 | build_current_row_loop(A_val, B, tl(PrevRow), hd(PrevRow), 0, [])]
        end,
        InitialPrevRow,
        A
    ),
    % The last element of the final row is dp[M][N].
    lists:last(FinalRow).

build_current_row_loop(_A_val, [], _PrevRow_tail, _Prev_j_minus_1_val, _Curr_j_minus_1_val, Acc) ->
    % Base case: All elements of B processed for the current A_val.
    % Reverse the accumulator to get the correct order.
    lists:reverse(Acc);
build_current_row_loop(A_val, [B_curr | B_rest], [P_curr | P_rest], Prev_j_minus_1_val, Curr_j_minus_1_val, Acc) ->
    % B_curr: B[j-1] (current element from B)
    % P_curr: PrevRow[j] (value from the previous row, at current column j)
    % Prev_j_minus_1_val: PrevRow[j-1] (value from the previous row, at previous column j-1)
    % Curr_j_minus_1_val: CurrentRow[j-1] (value from the current row, at previous column j-1, already computed)

    NewVal = if A_val == B_curr ->
                 % If elements match, it's 1 + diagonal element from previous row.
                 1 + Prev_j_minus_1_val;
             else ->
                 % If elements don't match, take max of (skip A) or (skip B).
                 % skip A: PrevRow[j] (P_curr)
                 % skip B: CurrentRow[j-1] (Curr_j_minus_1_val)
                 max(P_curr, Curr_j_minus_1_val)
             end,
    % Recurse for the next element of B.
    % P_curr (which was PrevRow[j]) becomes Prev_j_minus_1_val for the next step.
    % NewVal (which is CurrentRow[j]) becomes Curr_j_minus_1_val for the next step.
    build_current_row_loop(A_val, B_rest, P_rest, P_curr, NewVal, [NewVal | Acc]).