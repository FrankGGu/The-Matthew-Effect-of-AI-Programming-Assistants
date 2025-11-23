-spec uncommon_from_sentences(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
uncommon_from_sentences(S1, S2) ->
    Words1 = binary:split(S1, <<" ">>, [global, trim]),
    Words2 = binary:split(S2, <<" ">>, [global, trim]),
    AllWords = Words1 ++ Words2,
    CountMap = lists:foldl(fun(Word, Acc) -> 
                               maps:update_with(Word, fun(Count) -> Count + 1 end, 1, Acc)
                           end, #{}, AllWords),
    UncommonWords = maps:fold(fun(Word, Count, Acc) -> 
                                 case Count of
                                     1 -> [Word | Acc];
                                     _ -> Acc
                                 end
                              end, [], CountMap),
    UncommonWords.