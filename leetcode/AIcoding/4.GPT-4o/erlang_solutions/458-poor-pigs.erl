-module(solution).
-export([poor_pigs/3]).

-spec poor_pigs(integer(), integer(), integer()) -> integer().
poor_pigs(Buckets, MinutesToDie, MinutesToTest) ->
    % Calculate the number of tests we can perform
    Tests = div(MinutesToTest, MinutesToDie),
    
    % Use the formula to find the minimum number of pigs required
    pigs_required(Tests, Buckets).

%% Helper function to calculate the minimum number of pigs
-spec pigs_required(integer(), integer()) -> integer().
pigs_required(Tests, Buckets) ->
    % Find the minimum number of pigs using the formula (T+1)^x >= N
    Pigs = find_min_pigs(Tests, Buckets, 0),
    Pigs.

%% Function to find the minimum number of pigs
-spec find_min_pigs(integer(), integer(), integer()) -> integer().
find_min_pigs(_, Buckets, Pigs) when (Tests + 1) ^ Pigs >= Buckets -> Pigs;
find_min_pigs(Tests, Buckets, Pigs) -> 
    find_min_pigs(Tests, Buckets, Pigs + 1).
