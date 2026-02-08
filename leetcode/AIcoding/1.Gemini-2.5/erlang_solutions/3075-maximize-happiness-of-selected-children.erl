-module(solution).
-export([maximize_happiness/2]).

maximize_happiness(Happiness, K) ->
    SortedHappiness = lists:reverse(lists:sort(Happiness)),
    calculate_total(SortedHappiness, K, 0, 0).

calculate_total([], _K, _SelectedCount, CurrentTotal) ->
    CurrentTotal;
calculate_total(_HappinessList, 0, _SelectedCount, CurrentTotal) ->
    CurrentTotal;
calculate_total([H | T], K, SelectedCount, CurrentTotal) ->
    EffectiveHappiness = max(0, H - SelectedCount),
    calculate_total(T, K - 1, SelectedCount + 1, CurrentTotal + EffectiveHappiness).