-module(solution).
-export([find_lex_smallest_valid_sequence/1]).

find_lex_smallest_valid_sequence(N) ->
    lists:flatten(find_sequence(N, [], 0)).

find_sequence(0, Acc, _) ->
    [lists:reverse(Acc)];
find_sequence(N, Acc, Open) when Open > 0 ->
    [find_sequence(N - 1, [')' | Acc], Open - 1) | find_sequence(N, [ '(' | Acc], Open + 1)];
find_sequence(N, Acc, Open) ->
    [find_sequence(N - 1, [ '(' | Acc], Open + 1)].