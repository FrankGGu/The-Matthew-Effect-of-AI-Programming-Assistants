-spec is_valid_pair(Char1 :: char(), Char2 :: char()) -> boolean().
is_valid_pair(Char1, Char2) ->
    (Char1 == $0 andalso Char2 == $9) orelse
    (Char1 == $9 andalso Char2 == $0) orelse
    (Char1 == $1 andalso Char2 == $2) orelse
    (Char1 == $2 andalso Char2 == $1) orelse
    (Char1 == $3 andalso Char2 == $4) orelse
    (Char1 == $4 andalso Char2 == $3) orelse
    (Char1 == $5 andalso Char2 == $6) orelse
    (Char1 == $6 andalso Char2 == $5) orelse
    (Char1 == $7 andalso Char2 == $8) orelse
    (Char1 == $8 andalso Char2 == $7).

-spec find_valid_pair(S :: unicode:unicode_binary()) -> boolean().
find_valid_pair(S) ->
    find_valid_pair(S, 0, byte_size(S) - 1).

find_valid_pair(S, I, Max) when I < Max ->
    Char1 = binary:at(S, I),
    Char2 = binary:at(S, I + 1),
    case is_valid_pair(Char1, Char2) of
        true -> true;
        false -> find_valid_pair(S, I + 1, Max)
    end;
find_valid_pair(_, _, _) -> false.