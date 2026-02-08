-module(solution).
-export([generateBinaryStrings/1]).

generateBinaryStrings(N) ->
    lists:map(fun(X) -> lists:flatten(X) end, generate(N, [], [])).

generate(0, Acc, Acc) ->
    [Acc];
generate(N, Prev, Acc) when N > 0 ->
    generate(N - 1, [1 | Prev], [[1 | Acc] | generate(N - 1, [0 | Prev], [[0 | Acc] | []])])].