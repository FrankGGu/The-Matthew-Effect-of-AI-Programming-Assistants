-module(count_common_words).
-export([count_common_words/2]).

count_common_words(Words1, Words2) ->
  Map1 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(V) -> V + 1 end, 1, Acc) end, #{}, Words1),
  Map2 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(V) -> V + 1 end, 1, Acc) end, #{}, Words2),
  count_common(Map1, Map2).

count_common(Map1, Map2) ->
  lists:sum([if maps:is_key(K, Map2) andalso maps:get(K, Map1) == 1 andalso maps:get(K, Map2) == 1 -> 1; true -> 0 end || K <- maps:keys(Map1)]).