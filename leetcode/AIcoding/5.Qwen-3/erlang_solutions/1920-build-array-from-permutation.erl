-module(build_array_from_permutation).
-export([build/1]).

build(P) ->
    build(P, 0, []).

build([], _, Acc) ->
    lists:reverse(Acc);
build([H | T], I, Acc) ->
    build(T, I + 1, [lists:nth(H + 1, P) | Acc]).