-module(solution).
-export([minimum_beans/1]).

minimum_beans(Beans) ->
    Total = lists:sum(Beans),
    Min = lists:min(Beans),
    Length = length(Beans),
    Total - Min * Length.