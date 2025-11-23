-module(solution).
-export([find_num_of_valid_words/2]).

find_num_of_valid_words(Words, Puzzles) ->
    WordMasks = lists:map(fun word_to_mask/1, Words),
    PuzzleMasks = lists:map(fun puzzle_to_mask/1, Puzzles),
    lists:map(fun({PuzzleMask, FirstCharMask}) ->
        lists:foldl(fun(WordMask, Count) ->
            case (WordMask band FirstCharMask =/= 0) andalso ((WordMask band PuzzleMask) =:= WordMask) of
                true -> Count + 1;
                false -> Count
            end
        end, 0, WordMasks)
    end, PuzzleMasks).

word_to_mask(Word) ->
    lists:foldl(fun(Char, Mask) ->
        Mask bor (1 bsl (Char - $a))
    end, 0, Word).

puzzle_to_mask(Puzzle) ->
    {lists:foldl(fun(Char, Mask) ->
        Mask bor (1 bsl (Char - $a))
    end, 0, Puzzle), 1 bsl (hd(Puzzle) - $a)}.