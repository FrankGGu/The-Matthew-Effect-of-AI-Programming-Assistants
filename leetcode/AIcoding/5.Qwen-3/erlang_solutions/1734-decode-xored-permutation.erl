-module(solution).
-export([decode_permutation/2]).

decode_permutation(Enc, N) ->
    EncSize = length(Enc),
    Max = 1 bsl N,
    FullXor = lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, lists:seq(1, Max - 1)),
    Perm = decode_permutation(Enc, FullXor, 1, []),
    lists:reverse(Perm).

decode_permutation([], _, _, Acc) ->
    Acc;
decode_permutation([E | T], FullXor, Index, Acc) ->
    Current = E bxor FullXor,
    decode_permutation(T, FullXor, Index + 1, [Current | Acc]).