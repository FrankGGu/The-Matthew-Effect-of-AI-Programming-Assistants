-module(find_common_characters).
-export([commonChars/1]).

commonChars(A) ->
  lists:foldl(
    fun(Word, Acc) ->
      intersect_chars(Word, Acc)
    end,
    string_to_char_list(hd(A)),
    tl(A)
  ).

intersect_chars(Word, Acc) ->
  intersect_chars_helper(string_to_char_list(Word), Acc, []).

intersect_chars_helper([], _, Res) ->
  Res;
intersect_chars_helper([Char | Rest], Acc, Res) ->
  case lists:member(Char, Acc) of
    true ->
      intersect_chars_helper(Rest, lists:delete(Char, Acc, 1), [Char | Res]);
    false ->
      intersect_chars_helper(Rest, Acc, Res)
  end.

string_to_char_list(Str) ->
  string:to_charlist(Str).