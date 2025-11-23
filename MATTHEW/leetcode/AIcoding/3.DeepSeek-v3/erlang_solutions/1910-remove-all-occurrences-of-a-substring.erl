-spec remove_occurrences(S :: unicode:unicode_binary(), Part :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_occurrences(S, Part) ->
    case binary:match(S, Part) of
        nomatch -> S;
        {Pos, Len} -> 
            NewS = <<(binary:part(S, 0, Pos))/binary, (binary:part(S, Pos + Len, byte_size(S) - Pos - Len))/binary>>,
            remove_occurrences(NewS, Part)
    end.