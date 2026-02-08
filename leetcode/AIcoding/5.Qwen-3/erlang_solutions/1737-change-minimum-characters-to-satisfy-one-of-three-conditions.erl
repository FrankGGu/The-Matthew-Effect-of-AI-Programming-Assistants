-module(solution).
-export([min_changes/2]).

min_changes(A, B) ->
    CountA = count_chars(A),
    CountB = count_chars(B),
    Min1 = min_changes_condition1(CountA, CountB),
    Min2 = min_changes_condition2(CountA, CountB),
    Min3 = min_changes_condition3(CountA, CountB),
    lists:min([Min1, Min2, Min3]).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> 
        maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc)
    end, maps:new(), Str).

min_changes_condition1(CountA, CountB) ->
    Total = maps:size(CountA) + maps:size(CountB),
    Sum = maps:fold(fun(_K, V, Acc) -> Acc + V end, 0, CountA) + maps:fold(fun(_K, V, Acc) -> Acc + V end, 0, CountB),
    Sum - (maps:size(CountA) + maps:size(CountB)).

min_changes_condition2(CountA, CountB) ->
    AKeys = maps:keys(CountA),
    BKeys = maps:keys(CountB),
    CommonKeys = lists:usort(lists:intersect(AKeys, BKeys)),
    Required = 0,
    Required.

min_changes_condition3(CountA, CountB) ->
    AKeys = maps:keys(CountA),
    BKeys = maps:keys(CountB),
    AllKeys = lists:usort(AKeys ++ BKeys),
    Required = 0,
    Required.