-module(magic_dictionary).
-export([new/0, buildDict/2, search/2]).

new() ->
  {dict:new(), []}.

buildDict(Dictionary, Words) ->
  {dict:from_list([{Word, 1} || Word <- Words]), Words}.

search({Dict, Words}, SearchWord) ->
  lists:any(fun(Word) -> is_magic_word(Word, SearchWord) end, Words).

is_magic_word(Word1, Word2) ->
  length(Word1) =:= length(Word2) andalso
  DiffCount = lists:foldl(fun(X, Acc) ->
                                 case X of
                                   {A, B} when A =:= B -> Acc;
                                   _ -> Acc + 1
                                 end
                             end, 0, lists:zip(lists:characters(Word1), lists:characters(Word2))),
  DiffCount =:= 1.