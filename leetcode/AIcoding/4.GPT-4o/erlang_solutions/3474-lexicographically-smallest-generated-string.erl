-module(solution).
-export([find_lex_smallest_generated_string/1]).

find_lex_smallest_generated_string(N) when N >= 0 ->
    find_lex_smallest_generated_string_helper(N, [], 0).

find_lex_smallest_generated_string_helper(0, Acc, _) ->
    lists:reverse(Acc);
find_lex_smallest_generated_string_helper(N, Acc, 0) ->
    find_lex_smallest_generated_string_helper(N - 1, [$a | Acc], 1);
find_lex_smallest_generated_string_helper(N, Acc, 1) ->
    find_lex_smallest_generated_string_helper(N - 1, [$b | Acc], 0);
find_lex_smallest_generated_string_helper(N, Acc, 2) ->
    find_lex_smallest_generated_string_helper(N - 1, [$a | Acc], 1);
find_lex_smallest_generated_string_helper(N, Acc, 3) ->
    find_lex_smallest_generated_string_helper(N - 1, [$b | Acc], 0).