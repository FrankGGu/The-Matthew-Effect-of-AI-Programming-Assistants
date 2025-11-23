-spec word_pattern(Pattern :: unicode:unicode_binary(), Str :: unicode:unicode_binary()) -> boolean().
word_pattern(Pattern, Str) ->
    Words = string:split(Str, " ", all),
    case length(Words) =:= size(Pattern) of
        false -> false;
        true ->
            P2W = maps:new(),
            W2P = maps:new(),
            check_pattern(Pattern, Words, P2W, W2P)
    end.

check_pattern(<<>>, [], _, _) -> true;
check_pattern(<<P:8, RestP/binary>>, [W | RestW], P2W, W2P) ->
    case {maps:get(P, P2W, undefined), maps:get(W, W2P, undefined)} of
        {undefined, undefined} ->
            NewP2W = maps:put(P, W, P2W),
            NewW2P = maps:put(W, P, W2P),
            check_pattern(RestP, RestW, NewP2W, NewW2P);
        {W, P} ->
            check_pattern(RestP, RestW, P2W, W2P);
        _ ->
            false
    end.