-spec repeated_character(S :: unicode:unicode_binary()) -> char().
repeated_character(S) ->
    repeated_character(S, #{}).

repeated_character(<<C/utf8, Rest/binary>>, Map) ->
    case maps:is_key(C, Map) of
        true -> C;
        false -> repeated_character(Rest, Map#{C => true})
    end.