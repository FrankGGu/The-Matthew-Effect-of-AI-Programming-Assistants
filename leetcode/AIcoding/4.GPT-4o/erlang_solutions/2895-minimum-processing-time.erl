-module(solution).
-export([minimum_processing_time/1]).

minimum_processing_time(Jobs) ->
    lists:sum(lists:sort(Jobs)).