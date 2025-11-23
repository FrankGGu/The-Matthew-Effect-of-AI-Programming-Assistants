-module(solution).
-export([count_elements/1]).

count_elements(List) ->
    Min = lists:min(List),
    Max = lists:max(List),
    lists:length(lists:filter(fun(X) -> X > Min andalso X < Max end, List)).