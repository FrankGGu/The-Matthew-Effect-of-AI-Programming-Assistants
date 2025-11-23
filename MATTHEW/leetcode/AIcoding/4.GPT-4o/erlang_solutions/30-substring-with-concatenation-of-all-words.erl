%% -spec find_substring(S :: unicode:unicode_binary(), Words :: [unicode:unicode_binary()]) -> [integer()].
find_substring(S, Words) ->
    WordLen = length(hd(Words)),
    WordsCount = length(Words),
    TotalLen = WordLen * WordsCount,
    WordMap = word_map(Words),
    find_substring(S, Words, WordLen, TotalLen, WordMap, 0, []).

find_substring(_, _, _, _, _, Pos, Acc) when Pos < 0 -> lists:reverse(Acc);
find_substring(S, Words, WordLen, TotalLen, WordMap, Pos, Acc) ->
    case substring_match(S, Pos, WordLen, TotalLen, WordMap) of
        true -> find_substring(S, Words, WordLen, TotalLen, WordMap, Pos + 1, [Pos | Acc]);
        false -> find_substring(S, Words, WordLen, TotalLen, WordMap, Pos + 1, Acc)
    end.

-spec substring_match(S :: unicode:unicode_binary(), Pos :: integer(), WordLen :: integer(), TotalLen :: integer(), WordMap :: map()) -> boolean().
substring_match(S, Pos, WordLen, TotalLen, WordMap) ->
    Substring = unicode:substring(S, Pos, TotalLen),
    case words_in_substring(Substring, WordLen, WordMap) of
        true -> true;
        false -> false
    end.

-spec words_in_substring(Substring :: unicode:unicode_binary(), WordLen :: integer(), WordMap :: map()) -> boolean().
words_in_substring(_, _, WordMap) when map:size(WordMap) == 0 -> true;
words_in_substring(Substring, WordLen, WordMap) ->
    case unicode:substring(Substring, 0, WordLen) of
        <<Word:unicode:binary()>> -> 
            case map:find(Word, WordMap) of
                {ok, _} -> words_in_substring(unicode:sub(Substring, WordLen, unicode:len(Substring) - WordLen), WordLen, map:delete(Word, WordMap));
                error -> false
            end;
        _ -> false
    end.

-spec word_map(Words :: [unicode:unicode_binary()]) -> map().
word_map(Words) -> 
    lists:foldl(fun(Word, Acc) -> map:update_with(Word, fun(_) -> 1 end, 0, Acc) end, map:new(), Words).
