-module(most_common_word).
-export([most_common_word/2]).

most_common_word(Paragraph, Banned) ->
    Words = string:split(Paragraph, " ", all),
    BannedSet = sets:from_list(Banned),
    Counts = count_words(Words, BannedSet, #{}),
    {Word, _} = lists:foldl(fun({W, C}, {BestWord, BestCount}) ->
        if C > BestCount -> {W, C};
           true -> {BestWord, BestCount}
        end
    end, {"", 0}, maps:to_list(Counts)),

    Word.

count_words([], _, Acc) -> Acc;
count_words([Word | Rest], BannedSet, Acc) ->
    CleanWord = string:to_lower(string:strip(Word)),
    case CleanWord of
        "" -> count_words(Rest, BannedSet, Acc);
        _ ->
            case sets:is_element(CleanWord, BannedSet) of
                true -> count_words(Rest, BannedSet, Acc);
                false ->
                    NewCount = maps:get(CleanWord, Acc, 0) + 1,
                    count_words(Rest, BannedSet, maps:put(CleanWord, NewCount, Acc))
            end
    end.