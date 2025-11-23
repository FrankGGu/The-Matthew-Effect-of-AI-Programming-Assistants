-spec get_words_in_longest_subsequence(_N :: integer(), _Words :: [unicode:unicode_binary()], _Groups :: [integer()]) -> [unicode:unicode_binary()].
get_words_in_longest_subsequence(_N, Words, Groups) ->
    {_, Result} = lists:foldl(fun
        ({Word, Group}, {PrevGroup, Acc}) when Group =/= PrevGroup ->
            {Group, [Word | Acc]};
        (_, Acc) ->
            Acc
    end, {-1, []}, lists:zip(Words, Groups)),
    lists:reverse(Result).