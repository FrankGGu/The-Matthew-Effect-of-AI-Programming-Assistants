-module(solution).
-export([solve/1]).

solve(S) ->
  {Vowels, Consonants} = lists:foldl(
    fun(Char, {V, C}) ->
      case is_vowel(Char) of
        true -> {update_count(Char, V), C};
        false -> {V, update_count(Char, C)}
      end
    end,
    {dict:new(), dict:new()},
    string:to_lower(S)
  ),

  MostFrequentVowel = find_most_frequent(Vowels),
  MostFrequentConsonant = find_most_frequent(Consonants),

  {MostFrequentVowel, MostFrequentConsonant}.

is_vowel(Char) ->
  lists:member(Char, "aeiou").

update_count(Char, Dict) ->
  case dict:find(Char, Dict) of
    {ok, Count} -> dict:update(Char, Count + 1, Dict);
    error -> dict:store(Char, 1, Dict)
  end.

find_most_frequent(Dict) ->
  find_most_frequent(dict:to_list(Dict), 0, $ ).

find_most_frequent([], _, Acc) ->
  Acc;
find_most_frequent([{Char, Count} | Rest], MaxCount, Acc) ->
  case Count > MaxCount of
    true -> find_most_frequent(Rest, Count, Char);
    false -> find_most_frequent(Rest, MaxCount, Acc)
  end.