-spec maximum_subsequence_length(Words :: [unicode:unicode_binary()], Groups :: [integer()]) -> integer().
maximum_subsequence_length(Words, Groups) ->
    {_, MaxLen} = lists:foldl(fun(Word, {PrevGroup, Len}) ->
        Group = lists:nth(1, Groups),
        if
            Group =/= PrevGroup -> {Group, Len + 1};
            true -> {PrevGroup, Len}
        end
    end, {-1, 0}, Words),
    MaxLen.