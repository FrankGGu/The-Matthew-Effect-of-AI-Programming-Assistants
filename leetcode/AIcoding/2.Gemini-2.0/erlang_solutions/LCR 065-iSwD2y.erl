-module(shortest_encoding).
-export([shortest_encoding/1]).

shortest_encoding(Words) ->
  Sorted = lists:sort(fun(A, B) -> length(B) < length(A) end, Words),
  encode(Sorted, []).

encode([Word | Rest], Acc) ->
  case lists:any(fun(Encoded) -> string:ends_with(Encoded, Word) end, Acc) of
    true -> encode(Rest, Acc);
    false -> encode(Rest, [Word | Acc])
  end;
encode([], Acc) ->
  lists:sum([length(W) + 1 || W <- Acc]).