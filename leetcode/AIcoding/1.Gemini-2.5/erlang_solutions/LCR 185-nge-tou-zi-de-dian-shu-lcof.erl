-module(solution).
-export([solve/1]).

solve(N) ->
    % Base case: For N=1 die, sums range from 1 to 6, each with a count of 1.
    % DP map stores {Sum => Count}
    DP = maps:from_list([{S, 1} || S <- lists:seq(1, 6)]),

    % Iterate from the 2nd die up to the Nth die
    % CurrentDP holds the sum counts for 'i' dice
    % NextDP will hold the sum counts for 'i+1' dice
    FinalCounts = lists:foldl(fun(_, CurrentDP) ->
                                        NextDP = maps:new(),
                                        maps:fold(fun(PrevSum, PrevCount, AccNextDP) ->
                                                          % For each existing sum from 'i' dice, add a new die (1 to 6 faces)
                                                          lists:foldl(fun(Face, InnerAccNextDP) ->
                                                                              NewSum = PrevSum + Face,
                                                                              % Update the count for NewSum in NextDP
                                                                              % If NewSum exists, add PrevCount to its value
                                                                              % If NewSum doesn't exist, initialize with PrevCount
                                                                              maps:update_with(NewSum, fun(OldVal) -> OldVal + PrevCount end, PrevCount, InnerAccNextDP)
                                                                      end, AccNextDP, lists:seq(1, 6))
                                                  end, NextDP, CurrentDP)
                              end, DP, lists:seq(2, N)), % Loop N-1 times

    % Calculate the total number of possible outcomes (6^N)
    TotalOutcomes = math:pow(6, N),

    % Get all unique sums and sort them in ascending order
    SortedSums = lists:sort(maps:keys(FinalCounts)),

    % Convert counts to probabilities
    lists:map(fun(Sum) ->
                      Count = maps:get(Sum, FinalCounts),
                      Count / TotalOutcomes
              end, SortedSums).