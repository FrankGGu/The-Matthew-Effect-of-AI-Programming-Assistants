-spec remove_comments(Source :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
remove_comments(Source) ->
    process_lines(Source, [], false).

process_lines([], Acc, _) ->
    lists:reverse(Acc);
process_lines([Line | Rest], Acc, InBlock) ->
    {NewLine, NewInBlock} = process_line(Line, InBlock),
    case NewLine of
        <<>> when not InBlock andalso NewInBlock ->
            process_lines(Rest, Acc, NewInBlock);
        <<>> ->
            process_lines(Rest, Acc, NewInBlock);
        _ when not InBlock ->
            process_lines(Rest, [NewLine | Acc], NewInBlock);
        _ ->
            process_lines(Rest, Acc, NewInBlock)
    end.

process_line(Line, InBlock) ->
    case InBlock of
        true ->
            process_in_block(Line);
        false ->
            process_not_in_block(Line)
    end.

process_in_block(Line) ->
    case binary:match(Line, <<"*/">>) of
        nomatch ->
            {<<>>, true};
        {Pos, _} ->
            Remaining = binary:part(Line, Pos + 2, byte_size(Line) - Pos - 2),
            process_not_in_block(Remaining)
    end.

process_not_in_block(Line) ->
    case binary:match(Line, <<"/*">>) of
        nomatch ->
            case binary:match(Line, <<"//">>) of
                nomatch ->
                    {Line, false};
                {Pos, _} ->
                    {binary:part(Line, 0, Pos), false}
            end;
        {BlockPos, _} ->
            case binary:match(Line, <<"//">>) of
                nomatch ->
                    process_block_start(Line, BlockPos);
                {LinePos, _} when LinePos < BlockPos ->
                    {binary:part(Line, 0, LinePos), false};
                _ ->
                    process_block_start(Line, BlockPos)
            end
    end.

process_block_start(Line, BlockPos) ->
    case binary:match(Line, <<"*/">>, [{scope, {BlockPos + 2, byte_size(Line) - BlockPos - 2}}]) of
        nomatch ->
            {binary:part(Line, 0, BlockPos), true};
        {Pos, _} ->
            Prefix = binary:part(Line, 0, BlockPos),
            Suffix = binary:part(Line, Pos + 2, byte_size(Line) - Pos - 2),
            Combined = <<Prefix/binary, Suffix/binary>>,
            process_not_in_block(Combined)
    end.