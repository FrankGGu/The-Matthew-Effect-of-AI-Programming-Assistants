-module(top_k_frequent_words).
-export([topKFrequent/2]).

topKFrequent(Words, K) ->
  WordsCounts = lists:foldl(fun(Word, Acc) ->
                                  case maps:find(Word, Acc) of
                                    {ok, Count} ->
                                      maps:put(Word, Count + 1, Acc);
                                    error ->
                                      maps:put(Word, 1, Acc)
                                  end
                              end, #{}, Words),
  SortedWords = lists:sort(fun({_, Count1}, {_, Count2}) ->
                                 if Count1 > Count2 then
                                   true
                                 else if Count1 == Count2 then
                                   Word1 < Word2
                                 else
                                   false
                                 end
                             end, maps:to_list(WordsCounts)),
  lists:map(fun({Word, _}) -> Word end, lists:sublist(SortedWords, 1, K)).