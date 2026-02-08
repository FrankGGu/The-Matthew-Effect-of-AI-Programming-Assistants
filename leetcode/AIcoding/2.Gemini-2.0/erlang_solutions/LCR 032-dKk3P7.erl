-module(valid_anagram).
-export([is_anagram/2]).

is_anagram(S, T) ->
  string_to_list(lists:sort(string_to_list(S))) == string_to_list(lists:sort(string_to_list(T))).

string_to_list(String) ->
  unicode:characters_to_list(String, utf8).