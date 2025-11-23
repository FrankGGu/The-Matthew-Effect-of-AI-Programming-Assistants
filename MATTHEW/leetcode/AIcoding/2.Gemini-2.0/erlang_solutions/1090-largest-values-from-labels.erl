-module(largest_values_from_labels).
-export([largest_values_from_labels/3]).

largest_values_from_labels(Values, Labels, NumWanted, UseLimit) ->
    ValuesWithLabels = lists:zip(Values, Labels),
    SortedValuesWithLabels = lists:sort(fun({V1, _}, {V2, _}) -> V1 > V2 end, ValuesWithLabels),
    largest_values_from_labels_helper(SortedValuesWithLabels, NumWanted, UseLimit, #{}, 0).

largest_values_from_labels_helper([], 0, _, _, Acc) ->
    Acc;
largest_values_from_labels_helper([], _, _, _, Acc) ->
    Acc;
largest_values_from_labels_helper([{Value, Label} | Rest], NumWanted, UseLimit, UsedLabels, Acc) ->
    case maps:get(Label, UsedLabels, 0) < UseLimit of
        true ->
            NewUsedLabels = maps:update_with(Label, fun(Count) -> Count + 1 end, 1, UsedLabels),
            largest_values_from_labels_helper(Rest, NumWanted - 1, UseLimit, NewUsedLabels, Acc + Value);
        false ->
            largest_values_from_labels_helper(Rest, NumWanted, UseLimit, UsedLabels, Acc)
    end.