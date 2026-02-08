-module(largest_substring_between_two_equal_characters).
-export([max_length_between_equal_characters/1]).

max_length_between_equal_characters(S) ->
  max_length_between_equal_characters(S, 0, 0).

max_length_between_equal_characters([], _, MaxLength) ->
  MaxLength;
max_length_between_equal_characters([H|T], Index, MaxLength) ->
  case find_last_index(H, T, Index + 1) of
    -1 ->
      max_length_between_equal_characters(T, Index + 1, MaxLength);
    LastIndex ->
      Length = LastIndex - Index - 1,
      NewMaxLength = max(MaxLength, Length),
      max_length_between_equal_characters(T, Index + 1, NewMaxLength)
  end.

find_last_index(Char, List, StartIndex) ->
  find_last_index(Char, List, StartIndex, -1).

find_last_index(_, [], _, LastIndex) ->
  LastIndex;
find_last_index(Char, [Char|T], Index, _) ->
  find_last_index(Char, T, Index + 1, Index);
find_last_index(Char, [_|T], Index, LastIndex) ->
  find_last_index(Char, T, Index + 1, LastIndex).

max(A, B) ->
  if A > B -> A;
     true -> B
  end.