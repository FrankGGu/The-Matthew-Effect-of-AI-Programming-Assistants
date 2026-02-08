-module(decode_message).
-export([decode/2]).

decode(Key, Message) ->
    KeyMap = maps:from_list([{Char, Index} || {Index, Char} <- lists:zip(lists:seq(0, 25), "abcdefghijklmnopqrstuvwxyz")]),
    decode(Message, Key, KeyMap, []).

decode([], _, _, Acc) ->
    lists:reverse(Acc);
decode([H | T], Key, KeyMap, Acc) ->
    if
        H == 32 -> decode(T, Key, KeyMap, [32 | Acc]);
        true ->
            KeyChar = lists:nth((maps:get(H, KeyMap, 0) rem length(Key)) + 1, Key),
            decode(T, Key, KeyMap, [KeyChar | Acc])
    end.