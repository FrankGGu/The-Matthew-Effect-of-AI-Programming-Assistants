-module(solution).
-export([minimumTime/1]).

minimumTime(S) ->
    N = length(S),

    LeftDP = calculate_left_dp(S),
    RightDP = calculate_right_dp(S),

    Costs = [L + R || {L, R} <- lists:zip(LeftDP, RightDP)],
    lists:min(Costs).

calculate_left_dp(S) ->
    % LeftDP[k] is the minimum cost to remove all '1's in S[0...k-1].
    % K represents the length of the prefix, so S[k-1] is the current character.
    % Base case: LeftDP[0] = 0 (empty prefix).
    % State for foldl: {PrevDPVal, AccDPRev, K}
    % PrevDPVal: LeftDP[K-1]
    % AccDPRev: List of [LeftDP[K-1], LeftDP[K-2], ..., LeftDP[0]]
    % K: Current length of prefix being considered (index + 1)
    {_FinalPrevDPVal, LeftDPRev} = lists:foldl(
        fun(Char, {PrevDPVal, AccDPRev, K}) ->
            NewDPVal = if
                           Char == $0$ -> PrevDPVal;
                           Char == $1$ -> min(PrevDPVal + 1, K)
                       end,
            {NewDPVal, [NewDPVal|AccDPRev], K + 1}
        end,
        {0, [0], 1}, % Initial state: PrevDPVal=0 (for LeftDP[0]), AccDPRev=[0], K=1 (for LeftDP[1])
        S
    ),
    lists:reverse(LeftDPRev). % Reverse to get [LeftDP[0], ..., LeftDP[N]]

calculate_right_dp(S) ->
    % RightDP[k] is the minimum cost to remove all '1's in S[k...N-1].
    % We calculate this by reversing the string and applying a similar logic to LeftDP.
    % Let SRev = reverse(S).
    % Let LeftDP_Rev[j] be the min cost to remove '1's in SRev[0...j-1].
    % SRev[j-1] corresponds to S[N-j].
    % The cost to remove S[N-j] from the right is N - (N-j) = j.
    % So, LeftDP_Rev[j] = min(LeftDP_Rev[j-1] + 1, j).
    % This LeftDP_Rev[j] is equivalent to RightDP[N-j].
    % If LeftDP_Rev = [L_0, L_1, ..., L_N], then L_j = RightDP[N-j].
    % So LeftDP_Rev = [RightDP[N], RightDP[N-1], ..., RightDP[0]].
    % Reversing this gives [RightDP[0], ..., RightDP[N]].

    SRev = lists:reverse(S),
    {_FinalPrevDPVal, RightDPRevAcc} = lists:foldl(
        fun(Char, {PrevDPVal, AccDP, K}) ->
            NewDPVal = if
                           Char == $0$ -> PrevDPVal;
                           Char == $1$ -> min(PrevDPVal + 1, K)
                       end,
            {NewDPVal, [NewDPVal|AccDP], K + 1}
        end,
        {0, [0], 1}, % Initial state: PrevDPVal=0 (for RightDP[N]), AccDP=[0], K=1
        SRev
    ),
    lists:reverse(RightDPRevAcc). % Reverse to get [RightDP[0], ..., RightDP[N]]