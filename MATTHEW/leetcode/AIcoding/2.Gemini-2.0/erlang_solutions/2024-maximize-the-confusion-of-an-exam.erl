-module(maximize_confusion).
-export([maximize_confusion/2]).

maximize_confusion(AnswerKey, K) ->
  max_confusion(AnswerKey, K, $T) + max_confusion(AnswerKey, K, $F).

max_confusion(AnswerKey, K, Char) ->
  max_confusion(AnswerKey, K, Char, 0, 0, 0, length(AnswerKey)).

max_confusion(_AnswerKey, _K, _Char, L, R, Count, Len) when R >= Len ->
  Len - L;
max_confusion(AnswerKey, K, Char, L, R, Count, Len) ->
  case string:at(AnswerKey, R + 1) of
    Char ->
      max_confusion(AnswerKey, K, Char, L, R + 1, Count, Len);
    _ ->
      if Count < K then
        max_confusion(AnswerKey, K, Char, L, R + 1, Count + 1, Len)
      else
        max(R - L, max_confusion(AnswerKey, K, Char, L + 1, R, Count - (case string:at(AnswerKey, L + 1) of Char -> 0; _ -> 1 end), Len))
      end
  end.