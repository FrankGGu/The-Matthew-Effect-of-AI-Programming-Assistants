-module(solution).
-export([sort_three_groups/1]).

sort_three_groups(List) ->
    lists:sort(fun(A, B) -> A < B end, List).