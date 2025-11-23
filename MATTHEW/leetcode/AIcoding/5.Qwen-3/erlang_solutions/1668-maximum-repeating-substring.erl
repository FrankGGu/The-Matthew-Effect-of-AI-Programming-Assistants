-module(maximum_repeating_substring).
-export([max_repeating/1]).

max_repeating(Str) ->
    max_repeating(Str, 1, length(Str), 0).

max_repeating(Str, Low, High, Ans) when Low > High ->
    Ans;
max_repeating(Str, Low, High, Ans) ->
    Mid = (Low + High) div 2,
    Sub = string:substr(Str, 1, Mid),
    Count = count_occurrences(Str, Sub),
    if
        Count > 0 ->
            max_repeating(Str, Mid + 1, High, Mid);
        true ->
            max_repeating(Str, Low, Mid - 1, Ans)
    end.

count_occurrences(Str, Sub) ->
    count_occurrences(Str, Sub, 0, 0).

count_occurrences(_, _, Pos, Count) when Pos + length(Sub) > length(Str) ->
    Count;
count_occurrences(Str, Sub, Pos, Count) ->
    case string:substr(Str, Pos + 1, length(Sub)) of
        Sub ->
            count_occurrences(Str, Sub, Pos + length(Sub), Count + 1);
        _ ->
            count_occurrences(Str, Sub, Pos + 1, Count)
    end.