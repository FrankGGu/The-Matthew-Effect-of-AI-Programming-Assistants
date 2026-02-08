-module(vertical_print).
-export([vertical_print/1]).

vertical_print(S) ->
  Words = string:split(S, " ", all),
  MaxLength = lists:max([length(Word) || Word <- Words]),
  vertical_print_helper(Words, MaxLength, 0, []).

vertical_print_helper(_, MaxLength, MaxLength, Acc) ->
  lists:reverse(Acc);
vertical_print_helper(Words, MaxLength, Index, Acc) ->
  Line = [get_char(Word, Index) || Word <- Words],
  TrimmedLine = trim_trailing_spaces(Line),
  vertical_print_helper(Words, MaxLength, Index + 1, [list_to_binary(TrimmedLine) | Acc]).

get_char(Word, Index) ->
  try
    lists:nth(Index + 1, string:to_character_list(Word))
  catch
    _:_ ->
      $\s
  end.

trim_trailing_spaces(Line) ->
  trim_trailing_spaces_helper(lists:reverse(Line), []).

trim_trailing_spaces_helper([], Acc) ->
  lists:reverse(Acc);
trim_trailing_spaces_helper([$\s | Rest], Acc) ->
  trim_trailing_spaces_helper(Rest, Acc);
trim_trailing_spaces_helper([H | Rest], Acc) ->
  lists:reverse([H | Rest ++ Acc]).