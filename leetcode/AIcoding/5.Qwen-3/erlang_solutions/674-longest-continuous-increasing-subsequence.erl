-module(solution).
-export([longest_increasing_subsequence/1]).

longest_increasing_subsequence([]) -> 0;
longest_increasing_subsequence([H|T]) ->
    longest_increasing_subsequence(T, H, 1, 1).

longest_increasing_subsequence([], _, _, Max) -> Max;
longest_increasing_subsequence([H|T], Prev, Current, Max) ->
    if
        H > Prev ->
            longest_increasing_subsequence(T, H, Current + 1, max(Max, Current + 1));
        true ->
            longest_increasing_subsequence(T, H, 1, max(Max, 1))
    end.