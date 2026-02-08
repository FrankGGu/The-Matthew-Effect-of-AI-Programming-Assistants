-module(solution).
-export([find_difference/2]).

find_difference(List1, List2) ->
    Unique1 = lists:usort(List1),
    Unique2 = lists:usort(List2),
    {lists:subtract(Unique1, Unique2), lists:subtract(Unique2, Unique1)}.