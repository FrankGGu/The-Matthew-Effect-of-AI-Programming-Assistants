-module(solution).
-export([min_cost/1]).

min_cost(Stones) ->
    min_cost_impl(Stones, 0).

min_cost_impl([_], MaxDiff) ->
    MaxDiff;
min_cost_impl([S1, S2 | Rest], CurrentMaxDiff) ->
    Diff = S2 - S1,
    NewMaxDiff = max(CurrentMaxDiff, Diff),
    min_cost_impl([S2 | Rest], NewMaxDiff).