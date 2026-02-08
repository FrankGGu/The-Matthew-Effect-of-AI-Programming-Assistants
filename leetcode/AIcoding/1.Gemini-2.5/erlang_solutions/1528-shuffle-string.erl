-module(solution).
-export([restore_string/2]).

restore_string(S, Indices) ->
    Pairs = lists:zip(Indices, S),
    SortedPairs = lists:sort(Pairs),
    [Char || {_, Char} <- SortedPairs].