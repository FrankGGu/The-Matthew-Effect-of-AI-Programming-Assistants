-module(solution).
-export([drop_missing_data/1]).

drop_missing_data(Data) ->
    lists:filter(fun(X) -> X /= undefined end, Data).