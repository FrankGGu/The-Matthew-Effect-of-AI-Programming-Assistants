-module(solution).
-export([kth_grammar/2]).

-spec kth_grammar(N :: integer(), K :: integer()) -> integer().
kth_grammar(N, K) ->
    kth_grammar_recursive(N, K).

kth_grammar_recursive(1, _K) ->
    0;
kth_grammar_recursive(N, K) ->
    Mid = 1 bsl (N - 2),
    if
        K =< Mid ->
            kth_grammar_recursive(N - 1, K);
        true ->
            PrevChar = kth_grammar_recursive(N - 1, K - Mid),
            1 - PrevChar
    end.