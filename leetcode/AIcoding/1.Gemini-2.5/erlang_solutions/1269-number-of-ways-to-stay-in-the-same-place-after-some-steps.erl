-module(solution).
-export([numWays/2]).

numWays(Steps, ArrLen) ->
    Mod = 1000000007,
    % The maximum index we need to consider is limited by both arrLen and steps.
    % We cannot go beyond arrLen - 1.
    % Also, to return to index 0, the furthest we can go is steps / 2.
    % A safer upper bound for the index in the DP array is min(ArrLen - 1, Steps).
    % If Steps is large, ArrLen - 1 is the limit. If ArrLen is large, Steps is the limit.
    MaxIdx = min(ArrLen - 1, Steps),

    % Initialize the DP array for the previous step (step 0)
    % PrevDP[0] = 1 (1 way to be at index 0 after 0 steps)
    PrevDP = array:new([{size, MaxIdx + 1}, {fixed, true}]),
    PrevDP1 = array:set(0, 1, PrevDP),

    % Start the dynamic programming loop from step 1
    dp_loop(1, Steps, MaxIdx, PrevDP1, Mod).

dp_loop(K, Steps, MaxIdx, PrevDP, Mod) when K =< Steps ->
    % Initialize the DP array for the current step (step K)
    CurrDP = array:new([{size, MaxIdx + 1}, {fixed, true}]),

    % Iterate through all possible positions 'J' for the current step
    NewCurrDP = 
        lists:foldl(fun(J, AccDP) ->
            % Ways to reach position J at step K:
            % 1. Stay at J from J at step K-1
            Val = array:get(J, PrevDP),

            % 2. Move right to J from J-1 at step K-1
            Val1 = 
                if J > 0 ->
                    (Val + array:get(J - 1, PrevDP)) rem Mod;
                true ->
                    Val
                end,

            % 3. Move left to J from J+1 at step K-1
            Val2 = 
                if J < MaxIdx ->
                    (Val1 + array:get(J + 1, PrevDP)) rem Mod;
                true ->
                    Val1
                end,

            array:set(J, Val2, AccDP)
        end, CurrDP, lists:seq(0, MaxIdx)), % Iterate J from 0 to MaxIdx

    % Recurse for the next step, using NewCurrDP as PrevDP
    dp_loop(K + 1, Steps, MaxIdx, NewCurrDP, Mod);

dp_loop(_K, _Steps, _MaxIdx, PrevDP, _Mod) ->
    array:get(0, PrevDP).