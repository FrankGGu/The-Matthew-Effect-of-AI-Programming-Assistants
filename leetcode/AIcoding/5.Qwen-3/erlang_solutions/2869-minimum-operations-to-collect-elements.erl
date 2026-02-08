-module(minimum_operations_to_collect_elements).
-export([min_operations/1]).

min_operations(Elements) ->
    N = length(Elements),
    Required = lists:seq(1, N),
    collect(Elements, Required, 0).

collect([], _, Count) ->
    Count;
collect([H | T], Required, Count) when H == hd(Required) ->
    collect(T, tl(Required), Count + 1);
collect([_ | T], Required, Count) ->
    collect(T, Required, Count).