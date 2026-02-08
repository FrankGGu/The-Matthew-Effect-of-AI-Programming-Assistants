-module(decode_string).
-export([decode_string/1]).

decode_string(S) ->
    {Result, _} = decode(S, 0, []),
    Result.

decode([], _, Stack) ->
    {lists:reverse(Stack), []};
decode([H | T], N, Stack) when H >= $0, H =< $9 ->
    {Num, Rest} = parse_number(T, [H]),
    decode(Rest, Num, Stack);
decode([$\$, _ | T], N, Stack) ->
    {Sub, Rest} = decode(T, 0, []),
    decode(Rest, N, lists:append(lists:duplicate(N, Sub), Stack));
decode([H | T], N, Stack) ->
    decode(T, N, [H | Stack]).

parse_number([], Acc) ->
    {list_to_integer(lists:reverse(Acc)), []};
parse_number([H | T], Acc) when H >= $0, H =< $9 ->
    parse_number(T, [H | Acc]);
parse_number(_, Acc) ->
    {list_to_integer(lists:reverse(Acc)), []}.