-module(solution).
-export([poor_pigs/3]).

poor_pigs(Buckets, MinutesToDie, MinutesToTest) ->
    Rounds = MinutesToTest div MinutesToDie + 1,
    poor_pigs_impl(Buckets, Rounds, 0, 1).

poor_pigs_impl(Buckets, Rounds, Pigs, CurrentStates) when CurrentStates >= Buckets ->
    Pigs;
poor_pigs_impl(Buckets, Rounds, Pigs, CurrentStates) ->
    poor_pigs_impl(Buckets, Rounds, Pigs + 1, CurrentStates * Rounds).