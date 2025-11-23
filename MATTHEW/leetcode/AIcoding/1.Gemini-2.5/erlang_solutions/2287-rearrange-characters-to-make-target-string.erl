-module(solution).
-export([rearrange_characters/2]).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
                end, #{}, Str).

rearrange_characters(S, Target) ->
    SCounts = count_chars(S),
    TargetCounts = count_chars(Target),

    lists:foldl(fun({Char, TargetCount}, MinPossible) ->
                    SCount = maps:get(Char, SCounts, 0),
                    PossibleForChar = SCount div TargetCount,
                    min(MinPossible, PossibleForChar)
                end, infinity, maps:to_list(TargetCounts)).