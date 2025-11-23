-module(solution).
-export([num_unique_subjects/1]).

num_unique_subjects(Teachers) ->
    lists:map(fun(X) -> length(lists:usort(X)) end, Teachers).