-module(solution).
-export([combine/2]).

combine(N, K) ->
    combine_asc(1, N, K).

combine_asc(_Start, _N, 0) ->
    %% Base case: If K is 0, an empty list means a valid combination of K elements has been formed.
    [[]];
combine_asc(Start, N, K) when N - Start + 1 < K ->
    %% Pruning condition: If there are not enough remaining numbers (N - Start + 1)
    %% to pick K elements, then no valid combinations can be formed from this point.
    [];
combine_asc(Start, N, K) ->
    %% Option 1: Include 'Start' in the current combination.
    %% We need to find K-1 more numbers from 'Start + 1' to 'N'.
    CombinationsWithStart = combine_asc(Start + 1, N, K - 1),
    %% Prepend 'Start' to each combination found in the recursive call.
    ResultWithStart = [ [Start | C] || C <- CombinationsWithStart ],

    %% Option 2: Exclude 'Start' from the current combination.
    %% We need to find K numbers from 'Start + 1' to 'N'.
    ResultWithoutStart = combine_asc(Start + 1, N, K),

    %% Combine the results from both options.
    ResultWithStart ++ ResultWithoutStart.