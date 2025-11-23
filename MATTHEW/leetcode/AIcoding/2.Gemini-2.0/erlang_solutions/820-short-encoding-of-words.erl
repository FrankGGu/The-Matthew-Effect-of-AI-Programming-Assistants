-module(short_encoding).
-export([minimum_length_encoding/1]).

minimum_length_encoding(Words) ->
  SortedWords = lists:sort(fun(A, B) -> length(A) > length(B) end, Words),
  encode(SortedWords, []).

encode([], Acc) ->
  string:len(lists:concat(Acc)) + length(Acc);
encode([Word | Rest], Acc) ->
  case lists:any(fun(Encoded) -> string:suffix(Encoded, Word) end, Acc) of
    true ->
      encode(Rest, Acc);
    false ->
      encode(Rest, [Word ++ "$" | Acc])
  end.