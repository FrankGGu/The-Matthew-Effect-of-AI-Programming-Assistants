-module(uncommon_words).
-export([uncommon_from_sentences/2]).

uncommon_from_sentences(S1, S2) ->
  Words1 = string:tokens(S1, " "),
  Words2 = string:tokens(S2, " "),
  Counts1 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(C) -> C + 1 end, 1, Acc) end, #{}, Words1),
  Counts2 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(C) -> C + 1 end, 1, Acc) end, #{}, Words2),
  AllWords = lists:usort(Words1 ++ Words2),
  lists:filter(fun(W) -> 
                  (not maps:is_key(W, Counts1) orelse maps:get(W, Counts1) == 1) and 
                  (not maps:is_key(W, Counts2) orelse maps:get(W, Counts2) == 1) and
                  (maps:is_key(W, Counts1) xor maps:is_key(W, Counts2))
              end, AllWords).