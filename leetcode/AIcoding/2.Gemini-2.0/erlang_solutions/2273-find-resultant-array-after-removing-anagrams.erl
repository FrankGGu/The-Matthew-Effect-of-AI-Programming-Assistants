-module(find_anagrams).
-export([remove_anagrams/1]).

remove_anagrams(Words) ->
  remove_anagrams(Words, []).

remove_anagrams([], Acc) ->
  lists:reverse(Acc);
remove_anagrams([H|T], Acc) ->
  case Acc of
    [] ->
      remove_anagrams(T, [H]);
    [Last| _] ->
      if is_anagram(H, Last) ->
        remove_anagrams(T, Acc);
      else
        remove_anagrams(T, [H|Acc])
      end
  end.

is_anagram(S1, S2) ->
  lists:sort(string:to_lower(S1)) == lists:sort(string:to_lower(S2)).