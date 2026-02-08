-module(find_good_pairs_ii).
-export([num_identical_pairs/1]).

num_identical_pairs(Nums) ->
  num_identical_pairs(Nums, #{}, 0).

num_identical_pairs([], _, Count) ->
  Count;
num_identical_pairs([Num | Rest], Counts, Count) ->
  case maps:is_key(Num, Counts) of
    true ->
      NewCount = Count + maps:get(Num, Counts),
      NewCounts = maps:update(Num, maps:get(Num, Counts) + 1, Counts),
      num_identical_pairs(Rest, NewCounts, NewCount);
    false ->
      NewCounts = maps:put(Num, 1, Counts),
      num_identical_pairs(Rest, NewCounts, Count)
  end.