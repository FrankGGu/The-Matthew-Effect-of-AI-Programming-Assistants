-module(solution).
-export([find_pairs/1]).

find_pairs(Categories) ->
  find_pairs(Categories, []).

find_pairs([], Acc) ->
  lists:usort(Acc);
find_pairs([Category | Rest], Acc) ->
  find_pairs(Rest, Acc ++ find_pairs_for_category(Category, Rest)).

find_pairs_for_category(Category, Rest) ->
  find_pairs_for_category(Category, Rest, []).

find_pairs_for_category(_, [], Acc) ->
  Acc;
find_pairs_for_category(Category1, [Category2 | Rest], Acc) ->
  find_pairs_for_category(Category1, Rest, Acc ++ [{min(Category1, Category2), max(Category1, Category2)}]).