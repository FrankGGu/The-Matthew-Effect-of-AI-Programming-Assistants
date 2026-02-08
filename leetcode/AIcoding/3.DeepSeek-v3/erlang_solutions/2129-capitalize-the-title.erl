-spec capitalize_title(Title :: unicode:unicode_binary()) -> unicode:unicode_binary().
capitalize_title(Title) ->
    Words = binary:split(Title, <<" ">>, [global]),
    ProcessedWords = lists:map(fun(Word) ->
        case byte_size(Word) of
            Len when Len =< 2 -> string:lowercase(Word);
            _ ->
                LowerWord = string:lowercase(Word),
                <<First:8, Rest/binary>> = LowerWord,
                <<(First - 32), Rest/binary>>
        end
    end, Words),
    binary:list_to_bin(lists:join(<<" ">>, ProcessedWords)).