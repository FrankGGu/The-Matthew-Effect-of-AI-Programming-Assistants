-module(minimum_length_anagram_concatenation).
-export([min_anagram_concatenation/1]).

min_anagram_concatenation(S) ->
  min_anagram_concatenation(S, []).

min_anagram_concatenation([], Acc) ->
  length(Acc);
min_anagram_concatenation(S, Acc) ->
  case find_anagram_prefix(S) of
    {ok, Prefix} ->
      min_anagram_concatenation(lists:sublist(S, length(Prefix) + 1), Acc ++ [Prefix]);
    error ->
      length(Acc) + 1
  end.

find_anagram_prefix(S) ->
  find_anagram_prefix(S, 1).

find_anagram_prefix(S, Len) when Len > length(S) ->
  error;
find_anagram_prefix(S, Len) ->
  Prefix = lists:sublist(S, Len),
  Suffix = lists:sublist(S, Len, length(S) - Len),
  if is_anagram(Prefix, Suffix) ->
    {ok, Prefix};
  true ->
    find_anagram_prefix(S, Len + 1)
  end.

is_anagram(Prefix, Suffix) ->
  PrefixCounts = count_chars(Prefix),
  SuffixCounts = count_chars(Suffix),
  PrefixCounts == SuffixCounts.

count_chars(Str) ->
  count_chars(Str, []).

count_chars([], Acc) ->
  Acc;
count_chars([H|T], Acc) ->
  case lists:keyfind(H, 1, Acc) of
    false ->
      count_chars(T, [{H, 1} | Acc]);
    {H, Count} ->
      count_chars(T, lists:keyreplace(H, 1, Acc, {H, Count + 1}))
  end.