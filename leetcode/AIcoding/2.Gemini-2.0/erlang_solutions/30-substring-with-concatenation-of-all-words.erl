-module(substring_with_concatenation).
-export([find_substring/3]).

find_substring(S, Words, WordLen) ->
    Len = length(S),
    NumWords = length(Words),
    WordCount = word_count(Words),
    WordLength = case WordLen of
                     0 -> 0;
                     _ -> WordLen
                  end,
    Result = find_substring_helper(S, WordCount, WordLength, NumWords, Len, [], 0),
    lists:reverse(Result).

find_substring_helper(S, WordCount, WordLength, NumWords, Len, Acc, Start) ->
    if Start + WordLength * NumWords > Len then
        Acc
    else
        case check_substring(S, Start, WordCount, WordLength, NumWords) of
            true ->
                find_substring_helper(S, WordCount, WordLength, NumWords, Len, [Start | Acc], Start + 1);
            false ->
                find_substring_helper(S, WordCount, WordLength, NumWords, Len, Acc, Start + 1)
        end
    end.

check_substring(S, Start, WordCount, WordLength, NumWords) ->
    check_substring_helper(S, Start, WordCount, WordLength, NumWords, 0, {}).

check_substring_helper(S, Start, WordCount, WordLength, NumWords, Count, Seen) ->
    if Count == NumWords then
        true
    else
        WordStart = Start + Count * WordLength,
        Word = string:substr(S, WordStart + 1, WordLength),
        case maps:get(Word, WordCount, 0) of
            0 ->
                false;
            TotalCount ->
                SeenCount = maps:get(Word, Seen, 0),
                if SeenCount >= TotalCount then
                    false
                else
                    NewSeen = maps:put(Word, SeenCount + 1, Seen),
                    check_substring_helper(S, Start, WordCount, WordLength, NumWords, Count + 1, NewSeen)
                end
        end
    end.

word_count(Words) ->
    word_count_helper(Words, #{}).

word_count_helper([], Acc) ->
    Acc;
word_count_helper([Word | Rest], Acc) ->
    Count = maps:get(Word, Acc, 0),
    word_count_helper(Rest, maps:put(Word, Count + 1, Acc)).