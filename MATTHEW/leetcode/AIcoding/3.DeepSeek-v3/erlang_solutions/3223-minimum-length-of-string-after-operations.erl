-spec minimum_length(S :: unicode:unicode_binary()) -> integer().
minimum_length(S) ->
    minimum_length_helper(S, 0, byte_size(S) - 1).

minimum_length_helper(S, Left, Right) when Left >= Right ->
    if
        Left > Right -> 0;
        Left == Right -> 1
    end;
minimum_length_helper(S, Left, Right) ->
    case binary:at(S, Left) == binary:at(S, Right) of
        false ->
            Right - Left + 1;
        true ->
            Char = binary:at(S, Left),
            NewLeft = skip_chars(S, Left, Right, Char, 1),
            NewRight = skip_chars(S, Right, NewLeft, Char, -1),
            minimum_length_helper(S, NewLeft, NewRight)
    end.

skip_chars(S, Pos, Limit, Char, Step) ->
    if
        (Step > 0 andalso Pos =< Limit) orelse (Step < 0 andalso Pos >= Limit) ->
            case binary:at(S, Pos) of
                Char -> skip_chars(S, Pos + Step, Limit, Char, Step);
                _ -> Pos
            end;
        true ->
            Pos
    end.