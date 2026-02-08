-module(solution).
-export([decode_message/2]).

decode_message(Key, Message) ->
    Mapping = build_mapping(Key, #{}, $a),
    decode_message_chars(Message, Mapping, []).

build_mapping([], Map, _AlphabetChar) -> Map;
build_mapping([H | T], Map, AlphabetChar) when AlphabetChar > $z -> Map;
build_mapping([$ | T], Map, AlphabetChar) ->
    build_mapping(T, Map, AlphabetChar);
build_mapping([Char | T], Map, AlphabetChar) ->
    case maps:is_key(Char, Map) of
        true ->
            build_mapping(T, Map, AlphabetChar);
        false ->
            NewMap = maps:put(Char, AlphabetChar, Map),
            build_mapping(T, NewMap, AlphabetChar + 1)
    end.

decode_message_chars([], _Mapping, Acc) -> lists:reverse(Acc);
decode_message_chars([$ | T], Mapping, Acc) ->
    decode_message_chars(T, Mapping, [$ | Acc]);
decode_message_chars([Char | T], Mapping, Acc) ->
    MappedChar = maps:get(Char, Mapping),
    decode_message_chars(T, Mapping, [MappedChar | Acc]).