-module(solution).
-export([decode/2]).

decode(Enc, 0) -> Enc;
decode(Enc, Key) ->
    decode(Enc, Key, 1, [hd(Enc)]).

decode([], _, _, Acc) -> lists:reverse(Acc);
decode([H|T], Key, I, Acc) ->
    Dec = H bxor lists:nth(I, Key),
    decode(T, Key, I + 1, [Dec | Acc]).