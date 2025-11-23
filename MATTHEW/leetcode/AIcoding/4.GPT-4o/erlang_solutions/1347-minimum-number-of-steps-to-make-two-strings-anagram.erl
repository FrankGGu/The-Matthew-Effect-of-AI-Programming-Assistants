-module(solution).
-export([min_steps/2]).

min_steps(Str1, Str2) ->
    Count1 = counts(Str1),
    Count2 = counts(Str2),
    lists:sum(lists:map(fun({Char, C}) -> max(0, C - maps:get(Char, Count2, 0)) end, maps:to_list(Count1))) +
    lists:sum(lists:map(fun({Char, C}) -> max(0, C - maps:get(Char, Count1, 0)) end, maps:to_list(Count2))).

counts(Str) ->
    lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(C) -> C + 1 end, fun() -> 1 end, Acc) end, map(), list_to_binary(Str)).