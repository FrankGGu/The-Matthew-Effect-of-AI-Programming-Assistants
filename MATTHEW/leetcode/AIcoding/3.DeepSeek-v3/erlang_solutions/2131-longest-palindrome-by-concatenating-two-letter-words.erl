-spec longest_palindrome(Words :: [unicode:unicode_binary()]) -> integer().
longest_palindrome(Words) ->
    Freq = lists:foldl(fun(Word, Acc) ->
        maps:update_with(Word, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Words),
    {Count, HasCentral} = maps:fold(fun
        (<<A, B>>, Cnt, {Total, Central}) when A == B ->
            Pairs = Cnt div 2,
            {Total + Pairs * 2, Central orelse (Cnt rem 2 == 1)};
        (<<A, B>>, Cnt, {Total, Central}) ->
            case maps:get(<<B, A>>, Freq, 0) of
                0 -> {Total, Central};
                OtherCnt -> {Total + min(Cnt, OtherCnt), Central}
            end;
        (_, _, Acc) -> Acc
    end, {0, false}, Freq),
    (Count + (case HasCentral of true -> 1; false -> 0 end)) * 2.