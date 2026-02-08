-spec word_pattern(Pattern :: unicode:unicode_binary(), S :: unicode:unicode_binary()) -> boolean().
word_pattern(Pattern, S) ->
    Words = string:split(S, " "),
    word_pattern(Pattern, Words, #{}).

word_pattern([], [], _) -> true;
word_pattern([P|Ps], [W|Ws], M) ->
    case maps:get(P, M, undefined) of
        undefined ->
            case lists:member(W, maps:values(M)) of
                true -> false;
                false -> word_pattern(Ps, Ws, maps:put(P, W, M))
            end;
        Val when Val =:= W -> word_pattern(Ps, Ws, M);
        _ -> false
    end.
