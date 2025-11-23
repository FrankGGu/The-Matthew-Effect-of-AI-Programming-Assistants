-module(solution).
-export([findNumOfValidWords/2]).

char_to_bit(Char) ->
    1 bsl (Char - $a).

string_to_mask(S) ->
    lists:foldl(fun(Char, Mask) ->
        Mask bor char_to_bit(Char)
    end, 0, S).

findNumOfValidWords(Words, Puzzles) ->
    WordMaskCounts = lists:foldl(
        fun(Word, Acc) ->
            Mask = string_to_mask(Word),
            maps:update_with(Mask, fun(C) -> C + 1 end, 1, Acc)
        end,
        maps:new(),
        Words
    ),

    lists:map(
        fun(Puzzle) ->
            PuzzleFirstChar = hd(Puzzle),
            PuzzleFirstCharBit = char_to_bit(PuzzleFirstChar),
            PuzzleMask = string_to_mask(Puzzle),

            count_valid_words_for_puzzle(PuzzleMask, PuzzleMask, PuzzleFirstCharBit, WordMaskCounts, 0)
        end,
        Puzzles
    ).

count_valid_words_for_puzzle(CurrentSubmask, OriginalPuzzleMask, PuzzleFirstCharBit, WordMaskCounts, Acc) ->
    NewAcc = if
                 maps:is_key(CurrentSubmask, WordMaskCounts) ->
                     if
                         (CurrentSubmask band PuzzleFirstCharBit) /= 0 ->
                             Acc + maps:get(CurrentSubmask, WordMaskCounts);
                         true ->
                             Acc
                     end;
                 true ->
                     Acc
             end,

    NextSubmask = (CurrentSubmask - 1) band OriginalPuzzleMask,

    if
        CurrentSubmask > 0 ->
            count_valid_words_for_puzzle(NextSubmask, OriginalPuzzleMask, PuzzleFirstCharBit, WordMaskCounts, NewAcc);
        true ->
            NewAcc
    end.