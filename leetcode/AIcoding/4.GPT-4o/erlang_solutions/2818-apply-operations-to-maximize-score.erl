-module(solution).
-export([maximum_score/1]).

maximum_score(Numbers) ->
    MaxScore = lists:max(Numbers),
    FilteredNumbers = lists:filter(fun(X) -> X =< MaxScore end, Numbers),
    lists:sum(FilteredNumbers).