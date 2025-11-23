-module(sorting_sentence).
-export([sort_sentence/1]).

sort_sentence(S) ->
  Words = string:split(S, " ", all),
  SortedWords = lists:sort(
    fun(W1, W2) ->
      Index1 = list_to_integer(lists:droplast(string:to_list(W1))),
      Index2 = list_to_integer(lists:droplast(string:to_list(W2))),
      Index1 < Index2
    end,
    Words
  ),
  ResultWords = [lists:droplast(string:to_list(W)) || W <- SortedWords],
  string:join(ResultWords, " ").