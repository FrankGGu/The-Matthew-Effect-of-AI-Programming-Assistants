-module(solution).
-export([longestWord/1]).

longestWord(Words) ->
    SortedWords = lists:sort(Words),
    InitialValidWordsSet = gb_sets:new(),
    InitialLongestWord = [], % Empty list represents the initial longest word with length 0

    {FinalLongestWord, _} = lists:foldl(
        fun(Word, {CurrentLongestWord, CurrentValidWordsSet}) ->
            WordLen = string:len(Word),

            IsWordValid = 
                if 
                    WordLen == 1 ->
                        true;
                    true -> % WordLen > 1
                        Prefix = string:substr(Word, 1, WordLen - 1),
                        gb_sets:is_member(Prefix, CurrentValidWordsSet)
                end,

            if 
                IsWordValid ->
                    NewValidWordsSet = gb_sets:add(Word, CurrentValidWordsSet),
                    CurrentLongestWordLen = string:len(CurrentLongestWord),

                    NewLongestWord = 
                        if 
                            WordLen > CurrentLongestWordLen ->
                                Word;
                            WordLen == CurrentLongestWordLen ->
                                % If lengths are equal, choose the lexicographically smallest
                                if 
                                    Word < CurrentLongestWord -> % Erlang list comparison is lexicographical
                                        Word;
                                    true ->
                                        CurrentLongestWord
                                end;
                            true -> % WordLen < CurrentLongestWordLen
                                CurrentLongestWord
                        end,
                    {NewLongestWord, NewValidWordsSet};
                true -> % Not IsWordValid, so don't add to ValidWordsSet and don't update longest word
                    {CurrentLongestWord, CurrentValidWordsSet}
            end
        end,
        {InitialLongestWord, InitialValidWordsSet},
        SortedWords
    ),
    FinalLongestWord.