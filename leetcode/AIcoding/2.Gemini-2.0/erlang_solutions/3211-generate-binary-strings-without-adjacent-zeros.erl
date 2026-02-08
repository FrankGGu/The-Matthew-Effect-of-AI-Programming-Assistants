-module(gen_binary_strings).
-export([generate_binary_strings/1]).

generate_binary_strings(N) ->
    generate(N, 1, 1, 1, 1).

generate(0, Ones, Zeros, PrevOne, PrevZero) ->
    Ones + Zeros;
generate(N, Ones, Zeros, PrevOne, PrevZero) ->
    NewOnes = Ones + PrevZero,
    NewZeros = Zeros + PrevOne,
    generate(N - 1, NewOnes, NewZeros, NewOnes, NewZeros).