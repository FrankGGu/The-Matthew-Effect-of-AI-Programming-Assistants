-module(solution).
-export([firstDayBeenInAllRooms/1]).

-include_lib("array/include/array.hrl").

firstDayBeenInAllRooms(NextVisitList) ->
    N = length(NextVisitList),
    Mod = 1000000007,

    % Convert NextVisitList to an array for O(1) access
    NextVisit = array:from_list(NextVisitList),

    % DP array: dp[i] stores the day we first visit room i,
    % having visited rooms 0 to i-1 an even number of times.
    % Initialize DP array with N elements.
    DP = array:new([{size, N}, {fixed, true}]),

    % Base case: dp[0] = 0 (we are in room 0 on day 0)
    DP0 = array:set(0, 0, DP),

    % Iterate from i = 1 to N-1 to fill the DP array
    ResultDP = lists:foldl(
        fun(I, CurrentDP) ->
            % Get dp[i-1]
            PrevDP_val = array:get(I - 1, CurrentDP),

            % Get nextVisit[i-1]
            NextVisit_idx = array:get(I - 1, NextVisit),

            % Get dp[nextVisit[i-1]]
            NextVisitDP_val = array:get(NextVisit_idx, CurrentDP),

            % Calculate dp[i] using the recurrence relation:
            % dp[i] = (2 * dp[i-1] - dp[nextVisit[i-1]] + 2) % Mod
            Val = (2 * PrevDP_val - NextVisitDP_val + 2) rem Mod,

            % Ensure the result is positive (Erlang's rem can return negative for negative dividend)
            CorrectedVal = (Val + Mod) rem Mod,

            % Set dp[i] in the array
            array:set(I, CorrectedVal, CurrentDP)
        end,
        DP0,
        lists:seq(1, N - 1)
    ),

    % The answer is dp[N-1]
    array:get(N - 1, ResultDP).