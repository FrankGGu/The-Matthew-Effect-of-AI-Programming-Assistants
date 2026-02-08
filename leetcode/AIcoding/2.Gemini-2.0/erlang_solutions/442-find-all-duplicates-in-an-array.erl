-module(find_duplicates).
-export([find_duplicates/1]).

find_duplicates(Nums) ->
  find_duplicates(Nums, [], []).

find_duplicates([], _, Acc) ->
  Acc;
find_duplicates([Num | Rest], Seen, Acc) ->
  case lists:member(Num, Seen) of
    true ->
      find_duplicates(Rest, Seen, [Num | Acc]);
    false ->
      find_duplicates(Rest, [Num | Seen], Acc)
  end.