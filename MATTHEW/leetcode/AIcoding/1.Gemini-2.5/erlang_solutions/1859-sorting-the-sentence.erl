-module(solution).
-export([sortSentence/1]).

sortSentence(S) ->
    Words = string:tokens(S, " "),
    ParsedWords = lists:map(fun(Word) ->
                                    Len = length(Word),
                                    {WordPart, NumCharList} = lists:split(Len - 1, Word),
                                    {list_to_integer(NumCharList), WordPart}
                            end, Words),
    SortedWords = lists:sort(ParsedWords),
    ResultWords = [WordPart || {_, WordPart} <- SortedWords],
    string:join(ResultWords, " ").