-module(longest_decreasing_diff).
-export([longest_decreasing_subsequence/1]).

longest_decreasing_subsequence(Nums) ->
    longest_decreasing_subsequence(Nums, []).

longest_decreasing_subsequence([], Acc) ->
    length(Acc);
longest_decreasing_subsequence([H | T], []) ->
    longest_decreasing_subsequence(T, [H]);
longest_decreasing_subsequence([H | T], [Prev | _] = Acc) when H < Prev ->
    longest_decreasing_subsequence(T, [H | Acc]);
longest_decreasing_subsequence([H | T], [Prev | _] = Acc) ->
    longest_decreasing_subsequence(T, Acc).