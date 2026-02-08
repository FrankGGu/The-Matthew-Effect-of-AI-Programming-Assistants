-module(remove_duplicates_ii).
-export([removeDuplicates/2]).

removeDuplicates(S, K) ->
  removeDuplicatesHelper(S, [], K).

removeDuplicatesHelper([], Acc, _) ->
  lists:reverse([Char || {Char, _} <- Acc]);
removeDuplicatesHelper([Char | Rest], Acc, K) ->
  case Acc of
    [{LastChar, Count} | _] when Char == LastChar ->
      if Count + 1 == K then
        removeDuplicatesHelper(Rest, lists:delete([{LastChar, Count}], Acc), K)
      else
        removeDuplicatesHelper(Rest, [{Char, Count + 1} | lists:delete([{LastChar, Count}], Acc)], K)
      end;
    _ ->
      removeDuplicatesHelper(Rest, [{Char, 1} | Acc], K)
  end.