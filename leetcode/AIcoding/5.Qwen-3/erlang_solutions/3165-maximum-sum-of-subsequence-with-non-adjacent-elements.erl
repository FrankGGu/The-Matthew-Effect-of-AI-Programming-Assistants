-module(max_subsequence_sum).
-export([max_sum/1]).

max_sum([]) -> 0;
max_sum([H|T]) ->
    max_sum(H, T, 0, 0).

max_sum(_, [], prev_prev, prev) ->
    max(prev, prev_prev);
max_sum(Current, [Next|Rest], PrevPrev, Prev) ->
    CurrentMax = max(Prev, PrevPrev + Current),
    max_sum(Next, Rest, Prev, CurrentMax).