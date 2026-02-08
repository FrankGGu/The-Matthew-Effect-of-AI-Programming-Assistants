-module(solution).
-export([beautiful_partitions/2]).

-define(MOD, 1_000_000_007).

-spec is_prime_digit(char()) -> boolean().
is_prime_digit(C) ->
    C == $2 orelse C == $3 orelse C == $5 orelse C == $7.

-spec beautiful_partitions(string(), integer()) -> integer().
beautiful_partitions(S, K) ->
    N = length(S),
    SList = string:to_list(S),

    % Initial checks based on problem constraints and definition of beautiful partitions.
    % K cannot be greater than N.
    % K must be at least 1.
    % The first character of S must be a prime digit.
    % The last character of S must be a prime digit.
    case {K, N} of
        {_, _} when K > N -> 0;
        {_, _} when K < 1 -> 0;
        {_, _} when not is_prime_digit(hd(SList)) -> 0;
        {_, _} when not is_prime_digit(lists:last(SList)) -> 0;
        _ ->
            solve(SList, N, K)
    end.

-spec solve(list(), integer(), integer()) -> integer().
solve(SList, N, K) ->
    % Convert SList to an array for O(1) character access. SArray is 0-indexed.
    SArray = array:from_list(SList),

    % dp_prev_j_row represents dp[J-1] row. It's an array of size N+1.
    % dp[j][len] = number of ways to partition S[0...len-1] into j beautiful partitions.
    % Base case: dp[0][0] = 1 (0 partitions for an empty prefix). All other dp[0][len] = 0.
    % array:new(Size, {default, Value}) creates an array with all elements initialized to Value.
    dp_prev_j_row = array:set(0, 1, array:new(N + 1, {default, 0})),

    % Outer loop: Iterate J from 1 to K (number of partitions).
    % Acc_dp_prev_j_row holds the dp array for J-1 partitions.
    Final_dp_K_array = lists:foldl(
        fun(J, Acc_dp_prev_j_row) ->
            % dp_curr_j_row will store the dp array for J partitions. Initialize with zeros.
            dp_curr_j_row = array:new(N + 1, {default, 0}),
            CurrentSumForPrevJ = 0, % This sum accumulates dp[J-1][p] where S[p] is prime.

            % Inner loop: Iterate Len from 1 to N (length of prefix S[0...Len-1]).
            % {Acc_dp_curr_j_row_array, Acc_CurrentSum} is the state passed through the inner fold.
            % Acc_dp_curr_j_row_array is the dp[J] array being built.
            % Acc_CurrentSum is Sum_{p=0 to Len-1, S[p] is prime} dp[J-1][p].
            {_Final_dp_curr_j_row_array, _Final_CurrentSum} = lists:foldl(
                fun(Len, {Acc_dp_curr_j_row_array, Acc_CurrentSum}) ->
                    % S[Len-1] is the character at index Len-1.
                    Char_at_Len_minus_1 = array:get(Len - 1, SArray),
                    % dp[J-1][Len-1] is the value from the previous partition count.
                    Val_at_Len_minus_1_prev_j = array:get(Len - 1, Acc_dp_prev_j_row),

                    % Update the running sum `Acc_CurrentSum`.
                    % This sum should include `dp[J-1][Len-1]` if `S[Len-1]` is a prime digit.
                    % This updated sum will be used to calculate `dp[J][Len]`.
                    Updated_Acc_CurrentSum = Acc_CurrentSum,
                    if is_prime_digit(Char_at_Len_minus_1) ->
                        Updated_Acc_CurrentSum = (Acc_CurrentSum + Val_at_Len_minus_1_prev_j) rem ?MOD;
                    true ->
                        ok
                    end,

                    % Calculate `dp[J][Len]`.
                    % A beautiful partition must end with a prime digit.
                    New_dp_J_val = 0,
                    if is_prime_digit(Char_at_Len_minus_1) ->
                        % If S[Len-1] is prime, then dp[J][Len] is the sum of ways to form J-1 partitions
                        % ending at any p < Len, where S[p] is prime.
                        New_dp_J_val = Updated_Acc_CurrentSum;
                    true ->
                        ok
                    end,

                    % Update the current dp[J] array.
                    New_Acc_dp_curr_j_row_array = array:set(Len, New_dp_J_val, Acc_dp_curr_j_row_array),

                    {New_Acc_dp_curr_j_row_array, Updated_Acc_CurrentSum}
                end,
                {dp_curr_j_row, CurrentSumForPrevJ}, % Initial state for inner fold: empty dp[J] array, sum is 0.
                lists:seq(1, N) % Iterate Len from 1 to N.
            ),
            % The result of the inner fold is the computed dp[J] array.
            _Final_dp_curr_j_row_array % This becomes Acc_dp_prev_j_row for the next iteration (J+1).
        end,
        dp_prev_j_row, % Initial Acc_dp_prev_j_row for J=1 (which is dp[0] array).
        lists:seq(1, K) % Iterate J from 1 to K.
    ),

    % The final answer is dp[K][N], which is the last element of the Final_dp_K_array.
    array:get(N, Final_dp_K_array).