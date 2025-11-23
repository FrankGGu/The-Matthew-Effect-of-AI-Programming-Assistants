-spec reorder_log_files(Logs :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
reorder_log_files(Logs) ->
    {LetterLogs, DigitLogs} = lists:partition(fun(Log) ->
        case binary:split(Log, <<" ">>) of
            [_Identifier, <<FirstChar, _/binary>> | _] ->
                not (FirstChar >= $0 andalso FirstChar =< $9)
        end
    end, Logs),
    SortedLetterLogs = lists:sort(fun(A, B) ->
        {AIdentifier, AContent} = split_log(A),
        {BIdentifier, BContent} = split_log(B),
        case AContent == BContent of
            true -> AIdentifier < BIdentifier;
            false -> AContent < BContent
        end
    end, LetterLogs),
    SortedLetterLogs ++ DigitLogs.

split_log(Log) ->
    [Identifier | ContentParts] = binary:split(Log, <<" ">>, [global]),
    {Identifier, list_to_binary(lists:join(<<" ">>, ContentParts))}.