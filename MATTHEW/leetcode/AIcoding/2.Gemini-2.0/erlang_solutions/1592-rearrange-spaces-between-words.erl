-module(rearrange_spaces).
-export([rearrange_spaces/1]).

rearrange_spaces(Text) ->
  {Words, Spaces} = split_words_and_count_spaces(Text),
  NumWords = length(Words),
  case NumWords of
    1 ->
      lists:nth(1, Words) ++ string:copies(" ", Spaces);
    _ ->
      SpaceBetween = Spaces div (NumWords - 1),
      TrailingSpaces = Spaces rem (NumWords - 1),
      string:join(Words, string:copies(" ", SpaceBetween)) ++ string:copies(" ", TrailingSpaces)
  end.

split_words_and_count_spaces(Text) ->
  split_words_and_count_spaces(Text, [], 0).

split_words_and_count_spaces("", Words, Spaces) ->
  {lists:reverse(Words), Spaces};
split_words_and_count_spaces(Text, Words, Spaces) ->
  case string:strchr(Text, " ") of
    nomatch ->
      {lists:reverse([Text | Words]), Spaces};
    N ->
      {Word, Rest} = string:split(Text, " ", leading),
      split_words_and_count_spaces(Rest, [Word | Words], Spaces + 1)
  end.