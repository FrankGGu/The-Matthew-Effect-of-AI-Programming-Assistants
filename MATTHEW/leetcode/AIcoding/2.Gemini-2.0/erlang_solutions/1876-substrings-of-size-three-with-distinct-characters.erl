-module(substrings_size_three_distinct).
-export([countGoodSubstrings/1]).

countGoodSubstrings(S) ->
  countGoodSubstrings(S, 0).

countGoodSubstrings(S, Acc) ->
  Len = length(S),
  if
    Len < 3 ->
      Acc;
    true ->
      Sub = string:substr(S, 1, 3),
      if
        is_distinct(Sub) ->
          countGoodSubstrings(string:substr(S, 2, Len - 1), Acc + 1);
        true ->
          countGoodSubstrings(string:substr(S, 2, Len - 1), Acc)
      end
  end.

is_distinct(Sub) ->
  [C1, C2, C3] = string:to_list(Sub),
  C1 /= C2 and C1 /= C3 and C2 /= C3.