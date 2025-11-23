-module(word_replacement).
-export([replaceWords/2]).

replaceWords(Dict, Sentence) ->
  Words = string:split(Sentence, " ", all),
  lists:map(fun(Word) -> replace(Word, Dict) end, Words).

replace(Word, Dict) ->
  case find_prefix(Word, Dict) of
    "" -> Word;
    Prefix -> Prefix
  end.

find_prefix(Word, Dict) ->
  find_prefix_helper(Word, Dict, "").

find_prefix_helper(Word, [], Acc) ->
  Acc;
find_prefix_helper(Word, [H|T], Acc) ->
  case string:prefix(Word, H) of
    true ->
      if Acc == "" orelse string:len(H) < string:len(Acc) then
        find_prefix_helper(Word, T, H)
      else
        find_prefix_helper(Word, T, Acc)
      end;
    false ->
      find_prefix_helper(Word, T, Acc)
  end.