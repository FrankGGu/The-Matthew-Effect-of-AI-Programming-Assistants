-spec is_prefix_string(S :: unicode:unicode_binary(), Words :: [unicode:unicode_binary()]) -> boolean().
is_prefix_string(S, Words) ->
    is_prefix_string(S, Words, <<>>).

is_prefix_string(<<>>, _, _) -> true;
is_prefix_string(_, [], _) -> false;
is_prefix_string(S, [Word | Rest], Acc) ->
    NewAcc = <<Acc/binary, Word/binary>>,
    case binary:match(S, [NewAcc]) of
        {0, _} -> is_prefix_string(S, Rest, NewAcc);
        _ -> false
    end.