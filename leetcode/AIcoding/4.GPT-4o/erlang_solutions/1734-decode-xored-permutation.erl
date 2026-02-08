-module(solution).
-export([decode/1]).

decode(X) ->
    N = length(X) + 1,
    [xor(0, X, I) || I <- lists:seq(0, N - 1)].

xor(Prev, [], _) -> Prev;
xor(Prev, [H | T], I) ->
    New = Prev bxor H,
    [New | xor(New, T, I + 1)].