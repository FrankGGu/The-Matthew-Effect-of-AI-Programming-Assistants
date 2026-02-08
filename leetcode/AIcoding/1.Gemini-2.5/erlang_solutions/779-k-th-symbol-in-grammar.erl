-module(solution).
-export([kth_grammar/2]).

kth_grammar(1, 1) -> 0;
kth_grammar(N, K) ->
    Midpoint = 1 bsl (N - 2),
    if
        K =< Midpoint ->
            kth_grammar(N - 1, K);
        true ->
            SymbolInPrev = kth_grammar(N - 1, K - Midpoint),
            1 - SymbolInPrev
    end.