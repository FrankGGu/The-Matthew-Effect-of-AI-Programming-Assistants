-module(string_matching).
-export([string_matching/1]).

string_matching(Words) ->
  lists:foldl(fun(Word1, Acc) ->
                  lists:foldl(fun(Word2, Acc2) ->
                                  case string:str(Word2, Word1) of
                                    nomatch ->
                                      Acc2;
                                    _ ->
                                      case lists:member(Word1, Acc2) of
                                        true -> Acc2;
                                        false -> [Word1 | Acc2]
                                      end
                                  end
                              end, Acc, Words)
              end, [], Words).