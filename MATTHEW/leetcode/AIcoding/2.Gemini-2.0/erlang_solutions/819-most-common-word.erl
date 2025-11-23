-module(most_common_word).
-export([most_common_word/2]).

most_common_word(Paragraph, Banned) ->
  Words = re:split(string:lowercase(Paragraph), "[ !?',;.]+", [{return, list}, global]),
  FilteredWords = [W || W <- Words, not lists:member(W, Banned), W /= ""],
  Counts = lists:foldl(fun(Word, Acc) ->
                           case maps:is_key(Word, Acc) of
                             true -> maps:update(Word, maps:get(Word, Acc) + 1, Acc);
                             false -> maps:put(Word, 1, Acc)
                           end
                         end, #{}, FilteredWords),
  lists:keyfind(maps:size(Counts), 2, lists:sort(fun({_, C1}, {_, C2}) -> C1 > C2 end, maps:to_list(Counts))).