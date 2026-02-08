-module(rearrange_words).
-export([rearrange_words/1]).

rearrange_words(Text) ->
  Words = string:split(Text, " ", all),
  SortedWords = lists:keysort(length(hd(Words)), lists:map(fun(W) -> {string:length(W), W} end, Words)),
  CapitalizedFirstWord = string:uppercase(string:substr(hd(SortedWords),1,1)) ++ string:lowercase(string:substr(hd(SortedWords),2,string:length(hd(SortedWords)))),
  RestWords = lists:map(fun(W) -> string:lowercase(W) end, tl(SortedWords)),
  string:join([CapitalizedFirstWord | RestWords], " ").