-module(solution).
-export([num_perms_di_sequence/1]).

num_perms_di_sequence(S) ->
    N = length(S),
    MOD = 1000000007,

    % DPStates is a list of lists. Each inner list dp[i] represents the dp values for permutations of (0, ..., i).
    % dp[i][j] is the number of valid permutations of (0, ..., i)
    % such that P[i] (the last element, 0-indexed) is j.
    % j ranges from 0 to i.

    % Initial state: dp_prev = [1] for i=0 (permutation (0), P[0]=0)
    % The foldl accumulates states in reverse order, from dp[0] up to dp[N].
    DPStates = lists:foldl(
        fun(I, Acc) ->
            PrevDPList = hd(Acc), % PrevDPList is dp[I-1]
            CurrentDPList = calculate_current_dp(I, PrevDPList, S, MOD),
            [CurrentDPList | Acc]
        end,
        [[1]], % Initial dp for i=0
        lists:seq(1, N)
    ),

    % The final dp state is the head of the list (which is dp[N])
    FinalDPList = hd(DPStates), 

    % Sum all elements in FinalDPList
    lists:foldl(fun(X, Sum) -> (Sum + X) rem MOD end, 0, FinalDPList).

get_val(List, Index) ->
    % Helper to get 0-indexed value from a list, returning 0 if out of bounds
    if
        Index >= 0 andalso Index < length(List) ->
            lists:nth(Index + 1, List);
        true ->
            0
    end.

calculate_current_dp(I, PrevDPList, S, MOD) ->
    % S is 1-indexed for string:substr, so S[I] is S[I-1] in 0-indexed character string.
    Char = string:substr(S, I, 1), 

    CurrentDP = array:new([{size, I + 1}, {fixed, true}, {default, 0}]), % Use array for efficient updates

    if
        Char == "I" ->
            % For 'I': P[i-1] < P[i]
            % dp[i][j] = sum(dp[i-1][k]) for k from 0 to j-1
            % Optimized: dp[i][j] = dp[i][j-1] + dp[i-1][j-1] for j > 0
            % dp[i][0] = 0

            % CurrentPrefixSum accumulates sum(dp[i-1][k]) for k from 0 to J-1
            lists:foldl(
                fun(J, CurrentPrefixSum) ->
                    Val_PrevDP_J = get_val(PrevDPList, J),
                    array:set(J, CurrentPrefixSum, CurrentDP),
                    (CurrentPrefixSum + Val_PrevDP_J) rem MOD
                end,
                0, % Initial CurrentPrefixSum for dp[i][0]
                lists:seq(0, I) % J from 0 to I
            ),
            array:to_list(CurrentDP);
        Char == "D" ->
            % For 'D': P[i-1] > P[i]
            % dp[i][j] = sum(dp[i-1][k]) for k from j to i-1
            % Optimized: dp[i][j] = dp[i][j+1] + dp[i-1][j] for j < i
            % dp[i][i] = 0

            % CurrentSuffixSum accumulates sum(dp[i-1][k]) for k from J+1 to i-1
            lists:foldl(
                fun(J, CurrentSuffixSum) ->
                    Val_PrevDP_J = get_val(PrevDPList, J),
                    array:set(J, CurrentSuffixSum, CurrentDP),
                    (CurrentSuffixSum + Val_PrevDP_J) rem MOD
                end,
                0, % Initial CurrentSuffixSum for dp[i][i]
                lists:seq(I, 0, -1) % J from I down to 0
            ),
            array:to_list(CurrentDP)
    end.