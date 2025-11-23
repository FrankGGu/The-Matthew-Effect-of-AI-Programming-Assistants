-module(findNumOfValidWords).
-export([find_num_of_valid_words/2]).

find_num_of_valid_words(Words, Puzzles) ->
  WordSets = [list_to_set(lists:sort(list_to_bitset(Word))) || Word <- Words],
  [count_valid_words(Puzzle, WordSets) || Puzzle <- Puzzles].

count_valid_words(Puzzle, WordSets) ->
  FirstChar = list_to_integer([hd(Puzzle)]),
  PuzzleSet = list_to_bitset(Puzzle),
  count_valid_words_helper(PuzzleSet, FirstChar, WordSets, 0).

count_valid_words_helper(_PuzzleSet, _FirstChar, [], Count) ->
  Count;
count_valid_words_helper(PuzzleSet, FirstChar, [WordSet | Rest], Count) ->
  case sets:is_element(FirstChar, WordSet) andalso sets:is_subset(WordSet, PuzzleSet) of
    true ->
      count_valid_words_helper(PuzzleSet, FirstChar, Rest, Count + 1);
    false ->
      count_valid_words_helper(PuzzleSet, FirstChar, Rest, Count)
  end.

list_to_bitset(List) ->
  [char_to_bit(C) || C <- List].

char_to_bit(C) ->
  C - $a.