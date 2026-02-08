-module(replaceWords).
-export([replaceWords/2]).

replaceWords(Dict, Sentence) ->
  Words = string:split(Sentence, " ", all),
  ReplacedWords = [replaceWord(Word, Dict) || Word <- Words],
  string:join(ReplacedWords, " ").

replaceWord(Word, Dict) ->
  case findRoot(Word, Dict) of
    undefined ->
      Word;
    Root ->
      Root
  end.

findRoot(Word, Dict) ->
  findRootHelper(Word, Dict, []).

findRootHelper(_, [], Acc) ->
  case Acc of
    [] -> undefined;
    _ -> lists:min(Acc)
  end;
findRootHelper(Word, [Root | Rest], Acc) ->
  case string:starts_with(Word, Root) of
    true ->
      findRootHelper(Word, Rest, [Root | Acc]);
    false ->
      findRootHelper(Word, Rest, Acc)
  end.