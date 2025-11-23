-module(solution).
-export([longest_balanced_substring/1]).

longest_balanced_substring(Str) ->
    longest_balanced_substring(Str, 0, 0, 0).

longest_balanced_substring([], _, _, Max) ->
    Max;
longest_balanced_substring([$0 | T], ZeroCount, OneCount, Max) ->
    NewZero = ZeroCount + 1,
    NewOne = OneCount,
    if
        NewZero == NewOne ->
            longest_balanced_substring(T, NewZero, NewOne, max(Max, NewZero * 2));
        true ->
            longest_balanced_substring(T, NewZero, NewOne, Max)
    end;
longest_balanced_substring([$1 | T], ZeroCount, OneCount, Max) ->
    NewZero = ZeroCount,
    NewOne = OneCount + 1,
    if
        NewZero == NewOne ->
            longest_balanced_substring(T, NewZero, NewOne, max(Max, NewOne * 2));
        true ->
            longest_balanced_substring(T, NewZero, NewOne, Max)
    end.