-spec most_common_word(Paragraph :: unicode:unicode_binary(), Banned :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
most_common_word(Paragraph, Banned) ->
    LowerParagraph = string:lowercase(Paragraph),
    Words = re:split(LowerParagraph, "[ !?',;.]+", [{return, binary}, trim]),
    BannedSet = sets:from_list([string:lowercase(B) || B <- Banned]),
    Counts = lists:foldl(fun(Word, Acc) ->
                            case sets:is_element(Word, BannedSet) of
                                false -> 
                                    maps:update_with(Word, fun(V) -> V + 1 end, 1, Acc);
                                true -> 
                                    Acc
                            end
                        end, #{}, Words),
    {MaxWord, _} = lists:last(lists:keysort(2, maps:to_list(Counts))),
    MaxWord.