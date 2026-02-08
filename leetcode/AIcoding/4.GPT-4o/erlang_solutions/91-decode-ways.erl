-spec num_decodings(S :: unicode:unicode_binary()) -> integer().
num_decodings(S) -> 
    num_decodings(S, length(S), #{}).

num_decodings(_, 0, _) -> 1;
num_decodings(S, 1, _) -> 
    case string:substr(S, 1, 1) of
        "0" -> 0;
        _ -> 1
    end;
num_decodings(S, Len, _) when Len > 1 -> 
    case string:substr(S, Len - 1, 1) of
        "0" -> num_decodings(S, Len - 1, #{}); % invalid case
        _ -> num_decodings(S, Len - 1, #{}) + num_decodings(S, Len - 2, #{})
    end.
