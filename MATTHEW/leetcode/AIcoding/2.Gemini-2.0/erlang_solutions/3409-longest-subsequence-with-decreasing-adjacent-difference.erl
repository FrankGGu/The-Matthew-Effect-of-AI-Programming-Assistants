-module(longest_subsequence_with_decreasing_adjacent_difference).
-export([longest_subsequence/1]).

longest_subsequence(Nums) ->
    length(longest_subsequence_helper(Nums, [])).

longest_subsequence_helper([], Acc) ->
    Acc;
longest_subsequence_helper([H|T], []) ->
    longest_subsequence_helper(T, [H]);
longest_subsequence_helper([H|T], [Last|Rest]) ->
    Diff = Last - H,
    case Diff > 0 of
        true ->
            longest_subsequence_helper(T, [H|[Last|Rest]]);
        false ->
            longest_subsequence_helper(T, [Last|Rest])
    end.