-module(solution).
-export([find_common_elements/2]).

find_common_elements(A, B) ->
    Sets = lists:usort(A) -- lists:usort(B),
    Sets.