-module(solution).
-export([average_value/1]).

average_value(List) ->
    Filtered = lists:filter(fun(X) -> X rem 2 == 0 andalso X rem 3 == 0 end, List),
    case lists:length(Filtered) of
        0 -> 0;
        Count -> lists:sum(Filtered) div Count
    end.