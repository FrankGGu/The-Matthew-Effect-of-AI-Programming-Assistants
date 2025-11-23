-module(longest_balanced_substring).
-export([find_longest_balanced_substring/1]).

find_longest_balanced_substring(S) ->
  find_longest_balanced_substring(S, 0).

find_longest_balanced_substring(S, MaxLen) ->
  Len = length(S),
  find_longest_balanced_substring(S, 0, Len - 1, MaxLen).

find_longest_balanced_substring(_S, I, J, MaxLen) when I > J ->
  MaxLen;
find_longest_balanced_substring(S, I, J, MaxLen) ->
  case is_balanced(S, I, J) of
    true ->
      NewMaxLen = max(MaxLen, J - I + 1),
      NewMaxLen;
    false ->
      LeftMax = find_longest_balanced_substring(S, I + 1, J, MaxLen),
      RightMax = find_longest_balanced_substring(S, I, J - 1, LeftMax),
      RightMax
  end.

is_balanced(S, I, J) ->
  Zeros = count_chars(S, I, J, $0),
  Ones = count_chars(S, I, J, $1),
  Zeros == Ones.

count_chars(S, I, J, Char) ->
  count_chars(S, I, J, Char, 0).

count_chars(S, I, J, Char, Count) when I > J ->
  Count;
count_chars(S, I, J, Char, Count) ->
  case lists:nth(I + 1, S) of
    Char ->
      count_chars(S, I + 1, J, Char, Count + 1);
    _ ->
      count_chars(S, I + 1, J, Char, Count)
  end.