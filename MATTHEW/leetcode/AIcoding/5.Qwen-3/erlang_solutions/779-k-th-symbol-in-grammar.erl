-module(kth_symbol_in_grammar).
-export([kth_symbol_in_grammar/2]).

kth_symbol_in_grammar(N, K) ->
    kth_symbol_in_grammar(N, K, 0).

kth_symbol_in_grammar(1, 1, _) ->
    0;
kth_symbol_in_grammar(N, K, Depth) ->
    Parent = kth_symbol_in_grammar(N - 1, (K + 1) div 2, Depth + 1),
    if
        K rem 2 == 1 ->
            Parent;
        true ->
            1 - Parent
    end.