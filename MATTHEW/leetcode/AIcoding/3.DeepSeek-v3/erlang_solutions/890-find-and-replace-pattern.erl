-spec find_and_replace_pattern(Words :: [unicode:unicode_binary()], Pattern :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
find_and_replace_pattern(Words, Pattern) ->
    lists:filter(fun(Word) -> matches_pattern(Word, Pattern) end, Words).

matches_pattern(Word, Pattern) ->
    WordList = binary_to_list(Word),
    PatternList = binary_to_list(Pattern),
    case length(WordList) == length(PatternList) of
        false -> false;
        true ->
            WToP = maps:new(),
            PToW = maps:new(),
            check_mapping(WordList, PatternList, WToP, PToW)
    end.

check_mapping([], [], _, _) -> true;
check_mapping([W|Ws], [P|Ps], WToP, PToW) ->
    case {maps:is_key(W, WToP), maps:is_key(P, PToW)} of
        {false, false} ->
            NewWToP = maps:put(W, P, WToP),
            NewPToW = maps:put(P, W, PToW),
            check_mapping(Ws, Ps, NewWToP, NewPToW);
        {true, true} ->
            case {maps:get(W, WToP), maps:get(P, PToW)} of
                {P, W} -> check_mapping(Ws, Ps, WToP, PToW);
                _ -> false
            end;
        _ -> false
    end.