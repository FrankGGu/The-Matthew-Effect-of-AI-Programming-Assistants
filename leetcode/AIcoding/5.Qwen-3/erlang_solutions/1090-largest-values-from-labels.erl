-module(largest_values_from_labels).
-export([largest_values_from_labels/2]).

largest_values_from_labels(Values, Labels) ->
    largest_values_from_labels(Values, Labels, 0, []).

largest_values_from_labels([], _, _, Result) ->
    lists:reverse(Result);
largest_values_from_labels([V | Vs], [L | Ls], Count, Result) ->
    case Count < 3 of
        true ->
            {MaxValue, NewVs, NewLs} = find_max_with_label(Vs, Ls, V, L),
            largest_values_from_labels(NewVs, NewLs, Count + 1, [MaxValue | Result]);
        false ->
            lists:reverse(Result)
    end.

find_max_with_label([], [], CurrentValue, CurrentLabel) ->
    {CurrentValue, [], []};
find_max_with_label([V | Vs], [L | Ls], CurrentValue, CurrentLabel) ->
    if
        V > CurrentValue ->
            find_max_with_label(Vs, Ls, V, L);
        true ->
            find_max_with_label(Vs, Ls, CurrentValue, CurrentLabel)
    end.