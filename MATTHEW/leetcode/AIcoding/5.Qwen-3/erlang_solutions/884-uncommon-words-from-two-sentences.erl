-module(leetcode_791).
-export([uncommon_from_sentences/2]).

uncommon_from_sentences(Sentence1, Sentence2) ->
    Words1 = string:tokens(Sentence1, " "),
    Words2 = string:tokens(Sentence2, " "),
    Count = maps:fold(fun(Key, Val, Acc) -> maps:update_with(Key, fun(V) -> V + Val end, Val, Acc) end, 
                      maps:from_list([{W, 1} || W <- Words1 ++ Words2]), 
                      maps:from_list([{W, 1} || W <- Words1 ++ Words2])),
    [Word || Word <- lists:usort(Words1 ++ Words2), maps:get(Word, Count, 0) == 1].