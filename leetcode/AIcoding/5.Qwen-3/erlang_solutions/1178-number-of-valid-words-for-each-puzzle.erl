-module(solution).
-export([findNumOfValidWords/2]).

findNumOfValidWords(WordList, Puzzle) ->
    WordSet = lists:foldl(fun(W, Acc) -> sets:add_element(W, Acc) end, sets:new(), WordList),
    WordBits = lists:map(fun(W) -> word_to_bitmask(W) end, sets:to_list(WordSet)),
    lists:map(fun(P) -> count_valid_words(P, WordBits) end, Puzzle).

word_to_bitmask(Word) ->
    lists:foldl(fun(Char, Acc) -> Acc bor (1 bsl (Char - $a)) end, 0, Word).

count_valid_words(Puzzle, WordBits) ->
    PuzzleBit = word_to_bitmask(Puzzle),
    FirstChar = lists:nth(1, Puzzle),
    FirstBit = 1 bsl (FirstChar - $a),
    lists:foldl(fun(Bit, Acc) -> 
        if (Bit band FirstBit) /= 0 andalso (Bit band PuzzleBit) == Bit -> Acc + 1;
           true -> Acc
        end
    end, 0, WordBits).