-module(largest_outlier).
-export([largest_outlier/1]).

largest_outlier(List) ->
    Sorted = lists:sort(List),
    {Min, Max} = {hd(Sorted), hd(lists:reverse(Sorted))},
    case lists:filter(fun(X) -> X =:= Min orelse X =:= Max end, List) of
        [] -> undefined;
        Outliers -> lists:max(Outliers)
    end.