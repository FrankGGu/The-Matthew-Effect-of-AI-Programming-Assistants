-module(happy_string).
-export([get_happy_string/2]).

get_happy_string(N, K) ->
  get_happy_string(N, K, []).

get_happy_string(0, 1, Acc) ->
  lists:reverse(Acc);
get_happy_string(0, _, _) ->
  "".

get_happy_string(N, K, Acc) ->
  Last = case Acc of
    [] -> "";
    [H|_] -> [H]
  end,
  NextChars = get_next_chars(Last),
  Length = length(NextChars),
  Count = math:pow(2, N - 1),
  case K > Length * Count of
    true ->
      "";
    false ->
      Index = (K - 1) div Count,
      Char = lists:nth(Index + 1, NextChars),
      NewK = K - Index * Count,
      get_happy_string(N - 1, NewK, [Char | Acc])
  end.

get_next_chars("") ->
  "abc";
get_next_chars("a") ->
  "bc";
get_next_chars("b") ->
  "ac";
get_next_chars("c") ->
  "ab".