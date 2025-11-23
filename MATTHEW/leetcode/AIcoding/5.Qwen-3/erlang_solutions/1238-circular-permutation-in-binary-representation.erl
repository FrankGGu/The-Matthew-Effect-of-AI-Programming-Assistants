-module(circular_permutation).
-export([findCircularPermutation/2]).

findCircularPermutation(N, M) ->
    Permutation = generateGrayCode(N),
    lists:nth(M, Permutation).

generateGrayCode(N) ->
    generateGrayCode(N, 0, []).

generateGrayCode(0, _, Acc) ->
    Acc;
generateGrayCode(N, Start, Acc) ->
    Half = lists:reverse(generateGrayCode(N-1, Start, [])),
    [Start + X || X <- Half] ++ [Start + X || X <- Half].

generateGrayCode(0, _) ->
    [0];
generateGrayCode(N, Start) ->
    Half = generateGrayCode(N-1, Start),
    [Start + X || X <- Half] ++ [Start + X || X <- Half].