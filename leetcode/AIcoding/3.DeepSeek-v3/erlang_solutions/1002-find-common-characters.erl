-spec common_chars(Words :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
common_chars(Words) ->
    case Words of
        [] -> [];
        [First | Rest] ->
            FirstCount = count_chars(First),
            CommonCount = lists:foldl(fun(Word, Acc) ->
                WordCount = count_chars(Word),
                merge_counts(Acc, WordCount)
            end, FirstCount, Rest),
            build_result(CommonCount)
    end.

count_chars(Word) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, unicode:characters_to_list(Word)).

merge_counts(Count1, Count2) ->
    maps:fold(fun(Char, Cnt, Acc) ->
        case maps:get(Char, Count2, 0) of
            0 -> Acc;
            Cnt2 -> maps:put(Char, min(Cnt, Cnt2), Acc)
        end
    end, #{}, Count1).

build_result(Count) ->
    lists:flatmap(fun({Char, Cnt}) ->
        lists:duplicate(Cnt, <<Char/utf8>>)
    end, maps:to_list(Count)).