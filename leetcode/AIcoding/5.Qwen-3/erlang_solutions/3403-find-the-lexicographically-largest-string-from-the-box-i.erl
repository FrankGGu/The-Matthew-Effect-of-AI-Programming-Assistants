-module(solution).
-export([largest_string/1]).

largest_string(Box) ->
    lists:reverse(largest_string_helper(Box, [])).

largest_string_helper([], Acc) ->
    Acc;
largest_string_helper([H | T], Acc) ->
    largest_string_helper(T, [H | Acc]).