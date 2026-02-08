-module(solution).
-export([largest_values_from_labels/3]).

largest_values_from_labels(Values, Labels, K) ->
    Zip = lists:zip(Values, Labels),
    Sorted = lists:sort(fun({A1, _}, {A2, _}) -> A1 > A2 end, Zip),
    count_labels(Sorted, K, 0, #{}).

count_labels([], _, _, _) -> 0;
count_labels([{Value, Label} | Rest], K, Count, Used) ->
    case maps:is_key(Label, Used) of
        true -> count_labels(Rest, K, Count, Used);
        false when Count < K -> 
            NewCount = Count + 1,
            NewUsed = maps:put(Label, true, Used),
            Value + count_labels(Rest, K, NewCount, NewUsed);
        false -> count_labels(Rest, K, Count, Used)
    end.