-module(solution).
-export([find_num_of_valid_words/2]).

find_num_of_valid_words(Words, Puzzles) ->
    WordCount = lists:foldl(fun(W, Acc) -> 
        {alphabet(W), Acc + 1} 
    end, {dict:new(), 0}, Words),
    PuzzleCounts = lists:map(fun(P) -> 
        puzzle_count(P, WordCount)
    end, Puzzles),
    PuzzleCounts.

alphabet(Word) ->
    lists:foldl(fun(C, Acc) -> 
        dict:store(C, true, Acc) 
    end, dict:new(), string:to_lower(Word)).

puzzle_count(Puzzle, {WordDict, TotalCount}) ->
    FirstChar = hd(Puzzle),
    ValidWords = lists:filter(fun(W) -> 
        dict:find(FirstChar, W) =:= ok andalso valid_word(W, Puzzle) 
    end, dict:to_list(WordDict)),
    length(ValidWords).

valid_word(W, P) ->
    lists:all(fun(C) -> 
        dict:find(C, W) =:= ok 
    end, string:to_lower(P)).