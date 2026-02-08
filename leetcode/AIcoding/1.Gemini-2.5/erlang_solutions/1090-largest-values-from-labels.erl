-module(solution).
-export([largest_values_from_labels/4]).

largest_values_from_labels(Values, Labels, NumWanted, UseLimit) ->
    Combined = lists:zip(Values, Labels),
    Sorted = lists:sort(fun({V1, _}, {V2, _}) -> V1 >= V2 end, Combined),
    calculate_max_sum(Sorted, NumWanted, UseLimit, 0, 0, #{}).

calculate_max_sum([], _NumWanted, _UseLimit, CurrentSum, _PickedCount, _LabelCounts) ->
    CurrentSum;
calculate_max_sum(_Items, NumWanted, _UseLimit, CurrentSum, PickedCount, _LabelCounts) when PickedCount >= NumWanted ->
    CurrentSum;
calculate_max_sum([{Value, Label} | Rest], NumWanted, UseLimit, CurrentSum, PickedCount, LabelCounts) ->
    LabelCount = maps:get(Label, LabelCounts, 0),
    if
        LabelCount < UseLimit ->
            NewLabelCounts = maps:put(Label, LabelCount + 1, LabelCounts),
            calculate_max_sum(Rest, NumWanted, UseLimit, CurrentSum + Value, PickedCount + 1, NewLabelCounts);
        true ->
            calculate_max_sum(Rest, NumWanted, UseLimit, CurrentSum, PickedCount, LabelCounts)
    end.