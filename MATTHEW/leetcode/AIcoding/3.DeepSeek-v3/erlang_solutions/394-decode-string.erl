-module(solution).
-export([decode_string/1]).

decode_string(S) ->
    {Result, _} = decode(S, []),
    Result.

decode([], Stack) ->
    {[], Stack};
decode([$] | Rest], Stack) ->
    {Acc, NewStack} = pop_until_bracket(Stack, []),
    {Decoded, RemainingStack} = decode(Rest, NewStack),
    {Acc ++ Decoded, RemainingStack};
decode([Char | Rest], Stack) when Char >= $a, Char =< $z; Char >= $A, Char =< $Z ->
    {Decoded, NewStack} = decode(Rest, Stack),
    {[Char | Decoded], NewStack};
decode([Char | Rest], Stack) when Char >= $0, Char =< $9 ->
    {NumStr, Rest1} = collect_num([Char | Rest], []),
    Num = list_to_integer(NumStr),
    {Decoded, NewStack} = decode(Rest1, [Num | Stack]),
    {Decoded, NewStack};
decode([$[ | Rest], Stack) ->
    decode(Rest, Stack).

pop_until_bracket([], Acc) ->
    {Acc, []};
pop_until_bracket([H | T], Acc) when is_integer(H) ->
    pop_until_bracket(T, Acc);
pop_until_bracket([H | T], Acc) ->
    {lists:duplicate(H, Acc), T}.

collect_num([], Acc) ->
    {lists:reverse(Acc), []};
collect_num([Char | Rest], Acc) when Char >= $0, Char =< $9 ->
    collect_num(Rest, [Char | Acc]);
collect_num(Rest, Acc) ->
    {lists:reverse(Acc), Rest}.