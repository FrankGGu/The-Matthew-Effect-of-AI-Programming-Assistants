-spec capitalize_title(Title :: unicode:unicode_binary()) -> unicode:unicode_binary().
capitalize_title(Title) ->
    Words = binary:split(Title, <<" ">>, [global]),
    Capitalized = lists:map(fun(Word) ->
        case byte_size(Word) of
            Len when Len =< 2 -> string:lowercase(Word);
            _ ->
                <<First:8, Rest/binary>> = Word,
                <<(string:to_upper(First)), (string:lowercase(Rest))/binary>>
        end
    end, Words),
    binary:list_to_bin(lists:join(<<" ">>, Capitalized)).