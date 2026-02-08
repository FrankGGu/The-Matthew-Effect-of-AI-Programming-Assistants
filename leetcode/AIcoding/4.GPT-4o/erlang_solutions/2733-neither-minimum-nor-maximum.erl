-module(solution).
-export([find_non_min_max/1]).

find_non_min_max(List) ->
    case lists:sort(List) of
        Sorted when length(Sorted) > 2 ->
            Min = hd(Sorted),
            Max = lists:last(Sorted),
            lists:filter(fun(X) -> X > Min andalso X < Max end, Sorted);
        _ -> []
    end.