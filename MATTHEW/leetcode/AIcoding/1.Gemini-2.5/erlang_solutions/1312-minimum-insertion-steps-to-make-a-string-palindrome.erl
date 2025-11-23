-module(solution).
-export([min_insertions/1]).

min_insertions(S) ->
    N = length(S),
    S_rev = lists:reverse(S),
    LPS_len = lcs(S, S_rev, N),
    N - LPS_len.

lcs(S1, S2, N) ->
    % Initialize PrevRow (dp[0][j] for all j) with N+1 zeros.
    % This represents the row before processing the first character of S1.
    PrevRow = lists:duplicate(N + 1, 0),
    lcs_rows(S1, S2, N, PrevRow).

lcs_rows([], _S2, _N, PrevRow) ->
    % Base case: S1 is exhausted. The last element of the final PrevRow
    % (which is dp[N][N]) is the length of the LCS.
    lists:last(PrevRow);
lcs_rows([H1 | T1], S2, N, PrevRow) ->
    % H1 is the current character from S1 (S1[I-1]).
    % T1 is the rest of S1.

    % Build CurrRow (dp[I]) for the current character H1.
    % The arguments for lcs_build_curr_row are:
    %   H1: The current character from S1.
    %   S2: The full S2 string.
    %   PrevRow_remaining: `tl(PrevRow)` - represents `[dp[I-1][1], dp[I-1][2], ..., dp[I-1][N]]`.
    %   PrevRow_diag_val: `hd(PrevRow)` - this is `dp[I-1][0]`, which serves as `dp[I-1][J-1]` for J=1.
    %   CurrRow_left_val: `0` - this is `dp[I][0]`, which serves as `dp[I][J-1]` for J=1.
    %   Acc_CurrRow_reversed: `[0]` - starts with `dp[I][0]`, building the current row in reverse.
    CurrRow = lcs_build_curr_row(H1, S2, tl(PrevRow), hd(PrevRow), 0, [0]),
    % Recurse for the next character in S1, with CurrRow becoming PrevRow.
    lcs_rows(T1, S2, N, CurrRow).

lcs_build_curr_row(_S1_char, [], _PrevRow_remaining, _PrevRow_diag_val, _CurrRow_left_val, Acc_CurrRow_reversed) ->
    % Base case: S2 is exhausted for this row. Reverse the accumulator to get the correct order.
    lists:reverse(Acc_CurrRow_reversed);
lcs_build_curr_row(H1, [H2 | T2], [PrevRow_J | PrevRow_rest], PrevRow_diag_val, CurrRow_left_val, Acc_CurrRow_reversed) ->
    % H2 is the current character from S2 (S2[J-1]).
    % PrevRow_J is dp[I-1][J].

    New_CurrRow_J_val =
        if H1 == H2 ->
            % Characters match: 1 + value from diagonal (top-left) cell.
            1 + PrevRow_diag_val;
        true ->
            % Characters don't match: maximum of value from cell above (dp[I-1][J])
            % and value from cell to the left (dp[I][J-1]).
            max(PrevRow_J, CurrRow_left_val)
        end,
    % Recurse for the next column (J+1).
    % For the next step, PrevRow_J becomes the new PrevRow_diag_val.
    % New_CurrRow_J_val becomes the new CurrRow_left_val.
    lcs_build_curr_row(H1, T2, PrevRow_rest, PrevRow_J, New_CurrRow_J_val, [New_CurrRow_J_val | Acc_CurrRow_reversed]).