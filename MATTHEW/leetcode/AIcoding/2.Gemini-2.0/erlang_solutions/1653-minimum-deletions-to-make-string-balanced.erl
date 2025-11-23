-module(minimum_deletions).
-export([min_deletions/1]).

min_deletions(S) ->
    min_deletions_helper(S, 0, 0).

min_deletions_helper([], A_count, B_count) ->
    min(A_count, B_count).
min_deletions_helper([$a | T], A_count, B_count) ->
    min(
        min_deletions_helper(T, A_count + 1, B_count),
        1 + min_deletions_helper(T, A_count, B_count)
    );
min_deletions_helper([$b | T], A_count, B_count) ->
    min(
        min_deletions_helper(T, A_count, B_count + 1),
        1 + min_deletions_helper(T, A_count, B_count)
    ).