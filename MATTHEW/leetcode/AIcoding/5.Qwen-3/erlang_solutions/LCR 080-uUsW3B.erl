-module(combinations).
-export([combine/2]).

combine(N, K) ->
    generate(1, N, K, []).

generate(_, _, 0, Acc) ->
    [lists:reverse(Acc)];
generate(Start, N, K, Acc) ->
    lists:flatmap(fun(I) ->
        generate(I + 1, N, K - 1, [I | Acc])
    end, lists:seq(Start, N)).