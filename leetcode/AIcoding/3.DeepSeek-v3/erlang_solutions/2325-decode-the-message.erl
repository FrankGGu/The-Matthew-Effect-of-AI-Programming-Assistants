-spec decode_message(Key :: unicode:unicode_binary(), Message :: unicode:unicode_binary()) -> unicode:unicode_binary().
decode_message(Key, Message) ->
    KeyList = binary_to_list(Key),
    MessageList = binary_to_list(Message),
    SubTable = create_substitution_table(KeyList, #{}),
    decode(MessageList, SubTable, []).

create_substitution_table([], Map) -> Map;
create_substitution_table([Char | Rest], Map) ->
    case Char of
        $\s ->
            create_substitution_table(Rest, Map);
        _ ->
            case maps:is_key(Char, Map) of
                true ->
                    create_substitution_table(Rest, Map);
                false ->
                    NextChar = $a + maps:size(Map),
                    create_substitution_table(Rest, Map#{Char => NextChar})
            end
    end.

decode([], _, Acc) -> list_to_binary(lists:reverse(Acc));
decode([Char | Rest], SubTable, Acc) ->
    case Char of
        $\s ->
            decode(Rest, SubTable, [$\s | Acc]);
        _ ->
            decode(Rest, SubTable, [maps:get(Char, SubTable) | Acc])
    end.