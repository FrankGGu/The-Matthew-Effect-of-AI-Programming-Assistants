-module(delete_operation_two_strings).
-export([min_distance/2]).

min_distance(Word1, Word2) ->
  Len1 = length(Word1),
  Len2 = length(Word2),
  Lcs_Length = lcs_length(Word1, Word2, Len1, Len2),
  Len1 - Lcs_Length + Len2 - Lcs_Length.

lcs_length(Word1, Word2, Len1, Len2) ->
  lcs_length_helper(Word1, Word2, Len1, Len2, []).

lcs_length_helper(Word1, Word2, 0, _, Memo) ->
  0;
lcs_length_helper(Word1, Word2, _, 0, Memo) ->
  0;
lcs_length_helper(Word1, Word2, Len1, Len2, Memo) ->
  case lists:keyfind({Len1, Len2}, 1, Memo) of
    false ->
      case lists:nth(Len1, Word1) =:= lists:nth(Len2, Word2) of
        true ->
          Result = 1 + lcs_length_helper(Word1, Word2, Len1 - 1, Len2 - 1, Memo),
          lcs_length_helper(Word1, Word2, Len1 - 1, Len2 - 1, [{Len1, Len2, Result} | Memo]),
          Result;
        false ->
          Result1 = lcs_length_helper(Word1, Word2, Len1 - 1, Len2, Memo),
          Result2 = lcs_length_helper(Word1, Word2, Len1, Len2 - 1, Memo),
          Result = max(Result1, Result2),
          lcs_length_helper(Word1, Word2, Len1 - 1, Len2, [{Len1, Len2, Result} | Memo]),
          lcs_length_helper(Word1, Word2, Len1, Len2 - 1, [{Len1, Len2, Result} | Memo]),
          Result
      end;
    {_, _, Value} ->
      Value
  end.

max(A, B) ->
  if A > B -> A;
     true -> B
  end.