-module(longest_string_chain).
-export([longestStrChain/1]).

longestStrChain(Words) ->
  Dict = lists:foldl(fun(Word, Acc) -> maps:put(Word, 1, Acc) end, #{}, Words),
  lists:foldl(fun(Word, Max) -> max(Max, chainLength(Word, Dict)) end, 0, Words).

chainLength(Word, Dict) ->
  case maps:is_key(Word, Dict) of
    true ->
      Len = maps:get(Word, Dict),
      case Len > 1 of
        true ->
          Len;
        false ->
          NewLen = 1 + findPredecessors(Word, Dict),
          maps:put(Word, NewLen, Dict);
          NewLen
      end;
    false ->
      0
  end.

findPredecessors(Word, Dict) ->
  lists:foldl(fun(I, Max) ->
                NewWord = string:substr(Word, 1, I - 1) ++ string:substr(Word, I + 1, length(Word) - I),
                max(Max, chainLength(NewWord, Dict))
              end, 0, lists:seq(1, length(Word))).