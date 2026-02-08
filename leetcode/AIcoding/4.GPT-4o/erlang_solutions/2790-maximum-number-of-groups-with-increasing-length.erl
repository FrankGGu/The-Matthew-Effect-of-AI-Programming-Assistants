-module(solution).
-export([max_increasing_groups/1]).

max_increasing_groups(N) ->
    max_groups(N, 1, 0).

max_groups(N, Current, Count) when N >= Current ->
    max_groups(N - Current, Current + 1, Count + 1);
max_groups(_, _, Count) ->
    Count.