-module(solution).
-export([substr_count/2]).

substr_count(Chars, C) ->
    substr_count(Chars, C, 0, 0).

substr_count([], _, _, Count) ->
    Count;
substr_count([H | T], C, StartCount, Count) ->
    if
        H == C ->
            substr_count(T, C, StartCount + 1, Count + StartCount + 1);
        true ->
            substr_count(T, C, StartCount, Count)
    end.