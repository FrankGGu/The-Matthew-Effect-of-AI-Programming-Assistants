-module(solution).
-export([longestWord/1]).

longestWord(Words) ->
    SortedWords = lists:sort(Words),
    longest_word(SortedWords, [], []).

longest_word([], Longest, _) -> 
    Longest;
longest_word([H | T], Longest, Acc) -> 
    if 
        lists:member(H, Acc) -> 
            longest_word(T, max_word(Longest, H), [H | Acc]);
        true -> 
            longest_word(T, Longest, [H | Acc])
    end.

max_word([], New) -> New;
max_word([H | T], New) -> 
    if 
        length(H) > length(New) -> 
            max_word(T, H);
        length(H) < length(New) -> 
            max_word(T, New);
        true -> 
            max_word(T, New)
    end.