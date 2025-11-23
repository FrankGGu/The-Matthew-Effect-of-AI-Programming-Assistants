-module(solution).
-export([minimum_deletion_size/1]).

minimum_deletion_size(Strs) ->
    MinMax = lists:map(fun(S) -> {lists:min(S), lists:max(S)} end, Strs),
    Min = lists:min(lists:map(fun({Min, _}) -> Min end, MinMax)),
    Max = lists:max(lists:map(fun({_, Max}) -> Max end, MinMax)),
    lists:filter(fun(X) -> X =/= Min andalso X =/= Max end, lists:flatmap(fun({Min, Max}) -> [Min, Max] end, MinMax)).