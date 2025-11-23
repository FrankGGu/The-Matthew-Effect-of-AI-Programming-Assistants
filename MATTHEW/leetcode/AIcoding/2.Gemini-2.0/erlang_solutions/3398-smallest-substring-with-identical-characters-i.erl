-module(smallest_substring_identical_characters_i).
-export([solve/1]).

solve(S) ->
  solve(S, 1, length(S)).

solve(S, Min, Max) when Min > Max ->
  -1;
solve(S, Min, Max) ->
  Mid = (Min + Max) div 2,
  case has_substring_of_length(S, Mid) of
    true ->
      solve(S, Min, Mid - 1);
    false ->
      solve(S, Mid + 1, Max)
  end.

has_substring_of_length(S, Len) ->
  has_substring_of_length(S, Len, 1, length(S) - Len + 1).

has_substring_of_length(_S, _Len, Start, MaxStart) when Start > MaxStart ->
  false;
has_substring_of_length(S, Len, Start, _MaxStart) ->
  case check_substring(S, Start, Len) of
    true ->
      true;
    false ->
      has_substring_of_length(S, Len, Start + 1, length(S) - Len + 1)
  end.

check_substring(S, Start, Len) ->
  check_substring(S, Start, Len, string:at(S, Start)).

check_substring(_S, Start, 0, _Char) ->
  true;
check_substring(S, Start, Len, Char) ->
  case string:at(S, Start) =:= Char of
    true ->
      check_substring(S, Start + 1, Len - 1, Char);
    false ->
      false
  end.