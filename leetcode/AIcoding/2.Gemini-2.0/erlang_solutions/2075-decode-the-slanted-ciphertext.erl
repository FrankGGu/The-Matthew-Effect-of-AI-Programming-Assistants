-module(decode_slanted_ciphertext).
-export([decodeCiphertext/2]).

decodeCiphertext(EncodedText, Rows) ->
  Len = length(EncodedText),
  Cols = Len div Rows,
  PlainText = lists:foldl(
    fun(I, Acc) ->
      lists:append(Acc, [get_char(EncodedText, Rows, Cols, I)])
    end,
    [],
    lists:seq(0, Len - 1)
  ),
  string:trim(lists_to_binary(PlainText), trailing).

get_char(EncodedText, Rows, Cols, Index) ->
  Row = 0,
  Col = Index,
  CharIndex = Row * Cols + Col,
  if
    CharIndex >= length(EncodedText) ->
      $;
    true ->
      get_char_helper(EncodedText, Rows, Cols, Row, Col)
  end.

get_char_helper(EncodedText, Rows, Cols, Row, Col) ->
  if
    Row >= Rows orelse Col >= Cols ->
      $;
    true ->
      Index = Row * Cols + Col,
      lists:nth(Index + 1, string:to_list(EncodedText))
  end.