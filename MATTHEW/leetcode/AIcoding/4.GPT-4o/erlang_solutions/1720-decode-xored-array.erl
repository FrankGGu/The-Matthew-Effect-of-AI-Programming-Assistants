-module(solution).
-export([decode/2]).

decode(X, first) ->
    decode(X, first, [hd(X)]).

decode([], _, Acc) ->
    lists:reverse(Acc);
decode([H | T], First, Acc) ->
    New = First bxor H,
    decode(T, New, [New | Acc]).