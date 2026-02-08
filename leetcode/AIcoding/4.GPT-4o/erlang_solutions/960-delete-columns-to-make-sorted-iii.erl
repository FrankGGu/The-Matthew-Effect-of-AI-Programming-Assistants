-module(solution).
-export([min_deletion_size/1]).

min_deletion_size(Strs) ->
    N = length(Strs),
    M = string:length(hd(Strs)),
    Sorted = lists:map(fun(I) -> lists:map(fun(X) -> lists:nth(I, X) end, Strs) end, lists:seq(1, M)),
    SortedGroups = lists:map(fun(X) -> lists:sort(X) end, Sorted),
    UniqueGroups = lists:usort(SortedGroups),
    length(SortedGroups) - length(UniqueGroups).