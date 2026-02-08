-module(find_kth_character_ii).
-export([find_kth_character/2]).

find_kth_character(N, K) ->
  find_kth_character_helper(N, K, "a").

find_kth_character_helper(0, 1, Char) ->
  Char;
find_kth_character_helper(N, K, Char) ->
  Len = erlang:integer_to_list(math:pow(2, N)),
  HalfLen = erlang:length(Len),
  if K =< HalfLen ->
    find_kth_character_helper(N - 1, K, Char)
  else
    NextChar = case Char of
      "a" -> "b";
      "b" -> "a"
    end,
    find_kth_character_helper(N - 1, K - HalfLen, NextChar)
  end.