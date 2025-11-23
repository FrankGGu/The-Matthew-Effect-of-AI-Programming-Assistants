-module(remove_min_max).
-export([remove_min_max/1]).

remove_min_max(Arr) ->
    Min = lists:min(Arr),
    Max = lists:max(Arr),
    remove_min_max(Arr, Min, Max, []).

remove_min_max([], _, _, Acc) ->
    lists:reverse(Acc);
remove_min_max([H|T], Min, Max, Acc) ->
    case H of
        Min -> remove_min_max(T, Min, Max, Acc);
        Max -> remove_min_max(T, Min, Max, Acc);
        _ -> remove_min_max(T, Min, Max, [H|Acc])
    end.