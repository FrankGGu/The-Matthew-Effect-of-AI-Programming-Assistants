-module(count_words).
-export([word_count/2]).

word_count(StartWords, TargetWords) ->
    StartSet = sets:from_list([sort_string(Word) || Word <- StartWords]),
    lists:foldl(fun(TargetWord, Acc) ->
                        TargetSorted = sort_string(TargetWord),
                        case lists:any(fun(I) ->
                                               NewWord = remove_char(TargetSorted, I),
                                               sets:is_element(NewWord, StartSet)
                                       end, lists:seq(1, length(TargetSorted))) of
                            true -> Acc + 1;
                            false -> Acc
                        end
                end, 0, TargetWords).

sort_string(String) ->
    lists:sort(String).

remove_char(String, Index) ->
    {Part1, Part2} = lists:split(Index - 1, String),
    lists:append(Part1, tl(Part2)).